class seibertsoftwaresolutions::role::prod {
  include seibertsoftwaresolutions::profile::ui
  include seibertsoftwaresolutions::profile::api
  include seibertsoftwaresolutions::profile::db
}
