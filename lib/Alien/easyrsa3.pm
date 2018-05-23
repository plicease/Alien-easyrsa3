package Alien::easyrsa3;

use strict;
use warnings;
use 5.008001;
use Path::Tiny ();
use base qw( Alien::Base );
use Archive::Tar;
use Carp ();
use File::chdir;

# ABSTRACT: Download and use easy-rsa version 3
# VERSION

=head1 SYNOPSIS

 use Alien::easyrsa3;
 
 # extracts easy-rsa version 3 to ~/.easyrsa3/ca
 Alien::easyrsa3->extract('ca');

 # extracts easy-rsa version 3 to /full/path/eesa3
 Alien::easyrsa3->extract('/full/path/ersa3');

=head1 DESCRIPTION

This dist makes it easy to install easy-rsa version 3 using Perl and CPAN.

=head1 METHODS

In addition to the normal L<Alien::Base> methods, you get:

=head2 tarball

 my $path = Alien::easyrsa3->tarball;

Returns a L<Path::Tiny> object of the taball location.

=head2 extract

 Alien::easyrsa3->extract($path);

Extracts the tarball to the given location.  Must either be an
empty directory, or a non-existent directory that can be made.
If C<$path> is relative then it will be relative to C<~/.easyrsa3>.

=cut

sub tarball
{
  my($class) = @_;
  Path::Tiny->new($class->dist_dir)->child($class->runtime_prop->{my_tarball});
}

sub extract
{
  my($class, $path) = @_;
  $path = Path::Tiny->new($path);
  $path = Path::Tiny->new("~/.easyrsa3")->child($path) unless $path->is_absolute;
  $path->mkpath( { mode => 0700 } ) unless -d $path;
  Carp::croak "Unable to create: $path" unless -d $path;
  Carp::croak "Directory not empty: $path" unless $path->children == 0;
  
  local $CWD = "$path";
  my $archive = Archive::Tar->new;
  my @files = Archive::Tar->read($class->tarball);
  Carp::croak "Error reading tarball" unless @files > 0;

  foreach my $file (@files)
  {
    my @name = split /\//, $file->name;
    shift @name;
    my $name = join '/', @name;
    next if $name eq '';
    $file->extract($name) || Carp::croak "unable to extract $name";
  }
}

1;
