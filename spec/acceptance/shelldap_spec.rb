require 'spec_helper_acceptance'

describe 'shelldap class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      yumrepo { 'ubelix':
        ensure  => present,
        baseurl => 'http://gridadmin01.mgmt.ubelix.unibe.ch/mirror/ubelix/6/\$basearch',
        enabled => 1,
      }

      class { 'shelldap': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('shelldap') do
      it { is_expected.to be_installed }
    end
  end
end
