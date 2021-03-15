export default {
  resource: 'admin.adminPlugins',
  path: '/plugins',
  map() {
    this.route('sync-discord');
  }
};
