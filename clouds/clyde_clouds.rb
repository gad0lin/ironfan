require File.dirname(__FILE__)+'/cloud_aspects'

#
# EBS-backed cassandra ring in the cloud
# See the ../README.textile file for usage, etc
#
pool 'clyde' do
  cloud :slave do
    using :ec2
    settings = settings_for_node(name, :slave)
    instances                   (settings[:instances] || 4)
    #
    attaches_ebs_volumes        settings
    is_generic_node             settings
    is_nfs_client               settings
    is_chef_client              settings
    has_role                    settings, "infochimps_base"
    mounts_ebs_volumes          settings
    #
    is_cassandra_node           settings
    #
    has_big_package             settings
    has_role                    settings, "#{name}_cluster"
    user_data_is_json_hash      settings
  end
end


