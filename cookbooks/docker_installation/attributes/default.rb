default['docker_installation'] = {
  :IPV6 => 'yes',
  :DEFAULT_INPUT_POLICY => '"DROP"',
  :DEFAULT_OUTPUT_POLICY => '"ACCEPT"',
  :DEFAULT_FORWARD_POLICY => '"ACCEPT"',
  :DEFAULT_APPLICATION_POLICY => '"SKIP"',
  :MANAGE_BUILTINS => 'no',
  :IPT_SYSCTL => '/etc/ufw/sysctl.conf',
  :IPT_MODULES => '"nf_conntrack_ftp nf_nat_ftp nf_conntrack_netbios_ns"'
}
