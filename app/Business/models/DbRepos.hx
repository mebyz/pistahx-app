import promhx.Promise.Promise;

typedef DBAlbum = {
	findAll : FindAllOptions -> Promise<Array<DB__Album>>,
	find : FindOptions -> Promise<DB__Album>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBArtist = {
	findAll : FindAllOptions -> Promise<Array<DB__Artist>>,
	find : FindOptions -> Promise<DB__Artist>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBCustomer = {
	findAll : FindAllOptions -> Promise<Array<DB__Customer>>,
	find : FindOptions -> Promise<DB__Customer>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBEmployee = {
	findAll : FindAllOptions -> Promise<Array<DB__Employee>>,
	find : FindOptions -> Promise<DB__Employee>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBGenre = {
	findAll : FindAllOptions -> Promise<Array<DB__Genre>>,
	find : FindOptions -> Promise<DB__Genre>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBInvoice = {
	findAll : FindAllOptions -> Promise<Array<DB__Invoice>>,
	find : FindOptions -> Promise<DB__Invoice>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBInvoiceLine = {
	findAll : FindAllOptions -> Promise<Array<DB__InvoiceLine>>,
	find : FindOptions -> Promise<DB__InvoiceLine>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBMediaType = {
	findAll : FindAllOptions -> Promise<Array<DB__MediaType>>,
	find : FindOptions -> Promise<DB__MediaType>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBPlaylist = {
	findAll : FindAllOptions -> Promise<Array<DB__Playlist>>,
	find : FindOptions -> Promise<DB__Playlist>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBPlaylistTrack = {
	findAll : FindAllOptions -> Promise<Array<DB__PlaylistTrack>>,
	find : FindOptions -> Promise<DB__PlaylistTrack>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

typedef DBTrack = {
	findAll : FindAllOptions -> Promise<Array<DB__Track>>,
	find : FindOptions -> Promise<DB__Track>,
	build : Dynamic,
	save : Dynamic,
	then : Dynamic,
	hasOne : Dynamic,
	hasMany : Dynamic,
	belongsToMany : Dynamic,
	belongsTo : Dynamic
}

@:publicFields
class DbRepos {

	var dbAlbum : DBAlbum;
	var dbArtist : DBArtist;
	var dbCustomer : DBCustomer;
	var dbEmployee : DBEmployee;
	var dbGenre : DBGenre;
	var dbInvoice : DBInvoice;
	var dbInvoiceLine : DBInvoiceLine;
	var dbMediaType : DBMediaType;
	var dbPlaylist : DBPlaylist;
	var dbPlaylistTrack : DBPlaylistTrack;
	var dbTrack : DBTrack;
	function new(db : Sequelize) {

		dbAlbum = db.import_("models/Album.js");
		dbAlbum.hasOne(dbArtist, {foreignKey: 'ArtistId', as: 'Artist' });
		dbArtist = db.import_("models/Artist.js");
		dbCustomer = db.import_("models/Customer.js");
		dbCustomer.hasOne(dbEmployee, {foreignKey: 'EmployeeId', as: 'Employee' });
		dbEmployee = db.import_("models/Employee.js");
		dbEmployee.hasOne(dbEmployee, {foreignKey: 'EmployeeId', as: 'Employee' });
		dbGenre = db.import_("models/Genre.js");
		dbInvoice = db.import_("models/Invoice.js");
		dbInvoice.hasOne(dbCustomer, {foreignKey: 'CustomerId', as: 'Customer' });
		dbInvoiceLine = db.import_("models/InvoiceLine.js");
		dbInvoiceLine.hasOne(dbInvoice, {foreignKey: 'InvoiceId', as: 'Invoice' });
		dbMediaType = db.import_("models/MediaType.js");
		dbPlaylist = db.import_("models/Playlist.js");
		dbPlaylistTrack = db.import_("models/PlaylistTrack.js");
		dbPlaylistTrack.hasOne(dbPlaylist, {foreignKey: 'PlaylistId', as: 'Playlist' });
		dbTrack = db.import_("models/Track.js");
		dbTrack.hasOne(dbAlbum, {foreignKey: 'AlbumId', as: 'Album' });
	}
}
