require 'spec_helper'

describe 'shelldap::rc', :type => :define do
  let :pre_condition do
    'include shelldap'
  end
  let :default_facts do
    {
      :osfamily               => 'RedHat',
      :operatingsystemrelease => '6',
      :concat_basedir         => '/dne',
      :operatingsystem        => 'RedHat',
      :id                     => 'root',
      :kernel                 => 'Linux',
      :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :is_pe                  => false,
    }
  end
  let :default_params do
    {
      :server => 'auth01',
    }
  end
  let(:title) do
    'rspec-shelldap-rc'
  end

  describe 'os-independant items' do
    context 'shelldap::rc applying server only in default location' do
      let :facts do default_facts end
      let :params do default_params end

      it { is_expected.to compile }
      it { is_expected.to contain_shelldap__rc('rspec-shelldap-rc') }
      it { is_expected.to contain_file('/root/.shelldap.rc').with({
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0400',
        'path'   => '/root/.shelldap.rc',
      })
      }

      it { is_expected.to contain_file('/root/.shelldap.rc').with_content( /^server: auth01$/ ) }
    end

    context 'shelldap::rc in a typical scenario' do
      let :facts do default_facts end
      let :params do
        {
          :server    => 'ldaps://auth01.ubelix.unibe.ch',
          :binddn    => 'cn=root,dc=example,dc=com',
          :bindpass  => 'test',
          :basedn    => 'ou=users,dc=example,dc=com',
          :targetdir => '/root',
        }
      end

      it { is_expected.to contain_file('/root/.shelldap.rc').with({
        'ensure' => 'file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0400',
        'path'   => '/root/.shelldap.rc',
      })
      }

      it { is_expected.to contain_file('/root/.shelldap.rc').with_content( /^server: ldaps:\/\/auth01\.ubelix\.unibe\.ch$/ ) }
      it { is_expected.to contain_file('/root/.shelldap.rc').with_content( /^binddn: cn=root,dc=example,dc=com$/ ) }
      it { is_expected.to contain_file('/root/.shelldap.rc').with_content( /^bindpass: test$/ ) }
      it { is_expected.to contain_file('/root/.shelldap.rc').with_content( /^basedn: ou=users,dc=example,dc=com$/ ) }
    end
  end
end

