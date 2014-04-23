require 'formula'

class Arcanist < Formula
  homepage 'http://phabricator.org/'
  url 'https://github.com/facebook/arcanist/tarball/master'
  sha1 '0d5b47bdcaee608102a0120b0a7ab915ed9e4cbb'
  version '0.1'

  depends_on 'libphutil'

  head 'https://github.com/facebook/arcanist.git'
  
  def install
    # Get the location of libphutil so you can link arcanist to them
    var = "/usr/local/opt/libphutil"

    # Create the path where arcanist will look for libphutil
    FileUtils.mkdir_p 'externals/includes'

    # Link arcanist to libphutil
    cd "externals/includes" do
      File.symlink(var, "libphutil")
    end
    
    # Remove Windows scripts - BOOM!
    rm_rf Dir['bin/*.bat']

    prefix.install Dir['*']
  end

  def test
    system "true"
  end
end
