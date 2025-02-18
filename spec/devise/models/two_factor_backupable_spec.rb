require 'spec_helper'
require 'active_model'

ActiveRecord::Base.connection.create_table :two_factor_backupable_doubles, force: true do |t|
  t.string :otp_secret
end

class TwoFactorBackupableDouble < ActiveRecord::Base
  extend ::Devise::Models

  define_model_callbacks :update

  devise :two_factor_authenticatable, :two_factor_backupable,
         :otp_secret_encryption_key => 'test-key'*4

  attr_accessor :otp_backup_codes
end

describe ::Devise::Models::TwoFactorBackupable do
  context 'When included in a class' do
    subject { TwoFactorBackupableDouble.new }

    it_behaves_like 'two_factor_backupable'
  end
end
