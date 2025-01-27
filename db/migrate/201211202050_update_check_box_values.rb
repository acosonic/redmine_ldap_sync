class UpdateCheckBoxValues < ActiveRecord::Migration[4.2]

  def self.up
    all_settings = Setting.plugin_redmine_ldap_sync
    return unless all_settings

    AuthSourceLdapPasswd.all.each do |as|
      settings = all_settings[as.name]

      say_with_time "Updating settings for '#{as.name}'" do
        settings[:active]               = (['yes', '1'].include?(settings[:active])? '1': '0')
        settings[:create_groups]        = (['yes', '1'].include?(settings[:create_groups])? '1': '0')
        settings[:create_users]         = (['yes', '1'].include?(settings[:create_users])? '1': '0')
        settings[:sync_user_attributes] = (['yes', '1'].include?(settings[:sync_user_attributes])? '1': '0')
        Setting.plugin_redmine_ldap_sync = all_settings
      end if settings
    end
  end

  def self.down
    # nothing to do
  end
end
