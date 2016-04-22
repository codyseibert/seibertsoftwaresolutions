class seibertsoftwaresolutions::profile::db (
) {

  # if defined (Firewall['101 allow db access externally']) == false {
  #   firewall { '101 allow db access externally':
  #     dport   => [3306],
  #     proto  => tcp,
  #     action => accept,
  #   }
  # }
  #
  # class { '::mysql::server':
  #   # override_options => {
  #   #   mysqld => { bind-address => '0.0.0.0'}
  #   # },
  #   databases   => {
  #     'seibertsoftwaresolutions'  => {
  #       ensure  => 'present',
  #       charset => 'utf8',
  #     },
  #   },
  #   grants => {
  #     'seibertsoftwaresolutions@localhost/seibertsoftwaresolutions.*' => {
  #       ensure     => 'present',
  #       options    => ['GRANT'],
  #       privileges => ['SELECT', 'INSERT', 'CREATE', 'UPDATE', 'DELETE'],
  #       table      => 'seibertsoftwaresolutions.*',
  #       user       => 'seibertsoftwaresolutions@localhost',
  #     },
  #   },
  #   users => {
  #     'seibertsoftwaresolutions@localhost' => {
  #       ensure                   => 'present',
  #       max_connections_per_hour => '0',
  #       max_queries_per_hour     => '0',
  #       max_updates_per_hour     => '0',
  #       max_user_connections     => '0',
  #       password_hash            => '*11A9062C0914BDED584F42162D770125ACA0F7CE',
  #     }
  #   }
  # }

}
