require 'spec_helper_acceptance'

describe 'shelldap class' do

  context 'default parameters with rc file' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      include ::epel

      yumrepo { 'ubelix':
        ensure   => present,
        baseurl  => 'http://gridadmin01.mgmt.unibe.ch/mirror/ubelix/6/\$basearch',
        enabled  => 1,
        gpgcheck => 0,
      }

      class { 'shelldap':
        require => [ Class['epel'], Yumrepo['ubelix'] ],
      }

      shelldap::rc { 'root_shelldap_rc':
        server    => 'auth01',
        binddn    => 'cn=root,dc=example,dc=com',
        bindpass  => 'test',
        basedn    => 'ou=users,dc=example,dc=com',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('shelldap') do
      it { is_expected.to be_installed }
    end

    describe file('/root/.shelldap.rc') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_by 'root' }
      it { is_expected.to be_mode '0400' }
      it { is_expected.to contain 'server: auth01' }
      it { is_expected.to contain 'binddn: cn=root,dc=example,dc=com' }
      it { is_expected.to contain 'bindpass: test' }
      it { is_expected.to contain 'basedn: ou=users,dc=example,dc=com' }
    end
  end
end
