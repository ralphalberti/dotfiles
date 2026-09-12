# Download Verification Reference

**Version:** 1.0
**Last Updated:** 2026-09-12
**Status:** Living Document

# About This Document

This document describes methods for verifying downloaded files before they are
installed, executed, or otherwise trusted.

The primary methods covered are cryptographic hashes and GPG signatures.
These techniques can be used with ISO images, software archives, source code
releases, firmware images, AppImages, and other downloads when the publisher
provides the necessary verification information.

The purpose is to confirm that a downloaded file has not been corrupted or
modified and, when a trusted cryptographic signature is available, to provide
additional assurance that the verification information originated from the
expected publisher.

## Contents

- [Verification Concepts](#verification-concepts)
- [Checksums](#checksums)
- [GPG Signatures](#gpg-signatures)
- [Public Keys and Fingerprints](#public-keys-and-fingerprints)
- [Detached Signatures](#detached-signatures)
- [Signed Checksum Files](#signed-checksum-files)
- [Omarchy ISO Example](#omarchy-iso-example)
- [Interpreting Verification Results](#interpreting-verification-results)
- [Operational Reference](#operational-reference)
- [Related Documentation](#related-documentation)

# Verification Concepts

Download verification answers two related but different questions:

1. **Integrity** — Is the downloaded file identical to the file represented by
   the published verification information?
2. **Authenticity** — Is that verification information associated with the
   publisher expected to have produced the file?

Checksums primarily verify integrity.

Cryptographic signatures can provide both integrity verification and stronger
evidence of authenticity, provided the signing key itself has been
independently verified.

Neither technique determines whether the software itself is safe, trustworthy,
or free of vulnerabilities.

# Checksums

A cryptographic checksum is a fixed-length value calculated from the contents
of a file.

Even a small change to the file produces a different checksum.

SHA-256 is commonly used for software downloads.

Calculate the SHA-256 checksum of a file with:

```bash
sha256sum filename
```

Compare the resulting value with the checksum published by the software
provider.

For example:

```bash
sha256sum distribution.iso
```

A matching checksum confirms that the downloaded file matches the file
represented by the published checksum.

## Checksum Files

Publishers may provide a file containing checksums for one or more downloads.

A typical file may be named:

```text
SHA256SUMS
```

or:

```text
checksums.txt
```

When the file uses a format understood by `sha256sum`, verify the downloads
with:

```bash
sha256sum -c SHA256SUMS
```

Successful entries normally report:

```text
filename: OK
```

A checksum obtained from the same compromised location as the download does
not independently establish authenticity. When possible, use a signed checksum
file or obtain verification information through a trusted independent source.

# GPG Signatures

GPG signatures use public-key cryptography to verify that data was signed by
the holder of a corresponding private key.

The publisher keeps the private signing key secret and distributes the public
key.

The general process is:

```text
Publisher
    |
Private signing key
    |
Signs file or checksum information
    |
Signature
    |
Download
    |
Verify using publisher's public key
```

A successful signature verification demonstrates that the signed data has not
changed since it was signed by the corresponding private key.

The remaining question is whether that public key actually belongs to the
publisher expected to have created the download.

# Public Keys and Fingerprints

Before relying on a GPG signature, obtain the publisher's public key and verify
its fingerprint using an authoritative source.

Import a public key with:

```bash
gpg --import public-key-file
```

Display fingerprints for imported keys with:

```bash
gpg --fingerprint
```

A fingerprint is a compact representation of the public key and should be
compared carefully with the fingerprint published by the software provider.

The public key and the expected fingerprint should ideally not be obtained
solely from an untrusted mirror hosting the file being verified.

## Key Trust

GPG may successfully verify a signature while also warning that the signing
key is not certified with a trusted signature.

For example, GPG may report a good signature followed by a warning indicating
that there is no proof that the key belongs to the named owner.

These are separate questions:

```text
Does this signature mathematically match this key?
                     |
                    Yes
                     |
Does this key actually belong to the expected publisher?
                     |
              Verify fingerprint
```

A **Good signature** establishes the first relationship.

Independent verification of the key fingerprint helps establish the second.

# Detached Signatures

A detached signature is stored separately from the downloaded file.

Common signature filename extensions include:

```text
.sig
.asc
```

A download may therefore consist of:

```text
software.tar.xz
software.tar.xz.sig
```

Verify a detached signature with:

```bash
gpg --verify software.tar.xz.sig software.tar.xz
```

For an ISO image:

```bash
gpg --verify distribution.iso.sig distribution.iso
```

GPG reads the signature, identifies the signing key, and verifies that the
downloaded file matches the data that was signed.

If the required public key is not present in the local GPG keyring, it must be
obtained and imported before verification can succeed.

# Signed Checksum Files

Some projects sign a checksum file rather than signing every downloadable file
individually.

The verification chain then becomes:

```text
Publisher's public key
        |
        v
Verify signature on checksum file
        |
        v
Trusted checksum
        |
        v
Verify downloaded file
```

For example:

```bash
gpg --verify SHA256SUMS.sig SHA256SUMS
```

After the signature has been verified:

```bash
sha256sum -c SHA256SUMS
```

This verifies two relationships:

1. The checksum file was signed by the holder of the expected signing key.
2. The downloaded file matches the checksum contained in that signed file.

# Omarchy ISO Example

The Omarchy Linux ISO used for the original virtual-machine evaluation was
verified before installation.

The files included:

```text
omarchy-4.0.2.iso
omarchy-4.0.2.iso.sig
```

The Omarchy signing key identified itself as:

```text
Omarchy <pkgs@omarchy.org>
```

The verified fingerprint was:

```text
40DF B630 FF42 BCFF B047 046C F013 4EE6 80CA C571
```

After importing the signing key and verifying its fingerprint, the ISO was
checked with:

```bash
gpg --verify omarchy-4.0.2.iso.sig omarchy-4.0.2.iso
```

GPG reported a **Good signature** using the expected signing key.

GPG also displayed a warning concerning key trust. This did not indicate that
the signature verification failed. It indicated that GPG's local trust
database did not independently certify the relationship between the key and
the named owner.

The independently checked fingerprint supplied the important identity
verification step.

This example demonstrates why both the signature result and the identity of
the signing key should be considered.

# Interpreting Verification Results

## Matching Checksum

A matching checksum means:

- The downloaded file matches the data represented by the expected checksum.
- Accidental corruption or modification would normally produce a different
  checksum.

It does not by itself prove:

- Who created the file.
- That the publisher is trustworthy.
- That the software is safe.

## Good GPG Signature

A good GPG signature means:

- The signature mathematically matches the signed data.
- The signed data has not changed since the signature was created.
- The signature was created using the private key corresponding to the public
  key used for verification.

It does not by itself prove:

- That the public key belongs to the person or organization named on the key.
- That the signer is trustworthy.
- That the signed software is safe or free of malicious code.

The signing key's fingerprint should therefore be verified separately.

## Failed Verification

Do not use a download when:

- Its checksum differs from the expected checksum.
- Its cryptographic signature is invalid.
- The expected signing key cannot be established with reasonable confidence.

A failed verification should be investigated rather than bypassed.

Possible causes include:

- An incomplete or corrupted download.
- A mismatched signature and download version.
- An outdated checksum file.
- The wrong signing key.
- A modified download.

Re-download the file and obtain fresh verification information from the
publisher before proceeding.

# Operational Reference

## Calculate SHA-256

```bash
sha256sum filename
```

## Verify a Checksum File

```bash
sha256sum -c SHA256SUMS
```

## Import a GPG Public Key

```bash
gpg --import public-key-file
```

## Display Key Fingerprints

```bash
gpg --fingerprint
```

## Verify a Detached Signature

```bash
gpg --verify filename.sig filename
```

## Verify a Signed Checksum File

```bash
gpg --verify SHA256SUMS.sig SHA256SUMS
sha256sum -c SHA256SUMS
```

## Inspect Available GPG Keys

```bash
gpg --list-keys
```

# Related Documentation

- `docs/references/virtual-machines.md` — Arch Linux virtualization environment
  used for testing operating systems and software in isolated virtual machines.
