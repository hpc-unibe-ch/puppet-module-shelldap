require 'spec_helper'

describe 'shelldap' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "shelldap class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('shelldap::params') }
        it { should contain_class('shelldap::install').that_comes_before('shelldap::config') }
        it { should contain_class('shelldap::config') }
        it { should contain_class('shelldap::service').that_subscribes_to('shelldap::config') }

        it { should contain_service('shelldap') }
        it { should contain_package('shelldap').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'shelldap class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('shelldap') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
