require 'spec_helper'

describe 'shelldap' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "shelldap class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('shelldap::params') }
          it { is_expected.to contain_class('shelldap::install') }
          it { is_expected.to contain_class('shelldap') }

          it { is_expected.to contain_package('shelldap').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'shelldap class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('shelldap') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

