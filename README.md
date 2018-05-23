# Alien::easyrsa3 [![Build Status](https://secure.travis-ci.org/plicease/Alien-easyrsa3.png)](http://travis-ci.org/plicease/Alien-easyrsa3)

Download and use easy-rsa version 3

# SYNOPSIS

    use Alien::easyrsa3;
    
    # extracts easy-rsa version 3 to ~/.easyrsa3/ca
    Alien::easyrsa3->extract('ca');

    # extracts easy-rsa version 3 to /full/path/eesa3
    Alien::easyrsa3->extract('/full/path/ersa3');

# DESCRIPTION

This dist makes it easy to install easy-rsa version 3 using Perl and CPAN.

# METHODS

In addition to the normal [Alien::Base](https://metacpan.org/pod/Alien::Base) methods, you get:

## tarball

    my $path = Alien::easyrsa3->tarball;

Returns a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object of the taball location.

## extract

    Alien::easyrsa3->extract($path);

Extracts the tarball to the given location.  Must either be an
empty directory, or a non-existent directory that can be made.
If `$path` is relative then it will be relative to `~/.easyrsa3`.

# SEE ALSO

- [https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto](https://community.openvpn.net/openvpn/wiki/EasyRSA3-OpenVPN-Howto)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
