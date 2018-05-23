use Test2::V0 -no_srand => 1;
use Test2::Plugin::FauxHomeDir;
use Alien::easyrsa3;
use Path::Tiny ();

subtest 'tarball' => sub {

  my $path = Alien::easyrsa3->tarball;
  
  isa_ok $path, 'Path::Tiny';
  
  ok -f $path, 'file exists';
  
  ok($path->is_absolute, 'file is absolute');

};

subtest 'extract' => sub {

  subtest 'do not install to non-empty directory' => sub {
  
    my $dir = Path::Tiny->tempdir( "anyolddirXXXXXX" );
    $dir->child('child.txt')->touch;
    
    eval { Alien::easyrsa3->extract("$dir") };
    
    like $@, qr/Directory not empty/;
  
  };
  
  subtest 'install to a absolute url' => sub {

    my $dir = Path::Tiny->tempdir( "anyolddirXXXXXX" );
    
    Alien::easyrsa3->extract("$dir");
    
    ok( -f $dir->child('easyrsa'), "extracted at least the key tool" );

  };
  
  subtest 'install to a relative url' => sub {
  
    my $dir = Path::Tiny->new("~/.easyrsa3/foo");
    
    Alien::easyrsa3->extract("foo");
  
    ok( -f $dir->child('easyrsa'), "extracted at least the key tool" );

  };

};

done_testing
