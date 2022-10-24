CREATE TABLE IF NOT EXISTS style (
  name VARCHAR(50) NOT NULL CONSTRAINT pk_style PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS genre (
  name VARCHAR(50) NOT NULL CONSTRAINT pk_genre PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS artist (
  id INTEGER NOT NULL CONSTRAINT pk_artist PRIMARY KEY,
  data_quality VARCHAR(100),
  name VARCHAR(1000),
  profile TEXT,
  real_name VARCHAR(2000)
);

CREATE TABLE IF NOT EXISTS label (
  id INTEGER NOT NULL CONSTRAINT pk_label PRIMARY KEY,
  contact_info TEXT,
  data_quality VARCHAR(100),
  name VARCHAR(300),
  profile TEXT,
  parent_id INTEGER CONSTRAINT fk_label_parent_id_label_id REFERENCES label
);

CREATE TABLE IF NOT EXISTS master (
  id INTEGER NOT NULL CONSTRAINT pk_master PRIMARY KEY,
  data_quality VARCHAR(100),
  title VARCHAR(2000),
  released_year SMALLINT NOT NULL DEFAULT -1
);

CREATE TABLE IF NOT EXISTS release (
  id INTEGER NOT NULL CONSTRAINT pk_release PRIMARY KEY,
  country VARCHAR(100),
  data_quality VARCHAR(100),
  released_day TINYINT NOT NULL DEFAULT -1,
  released_month TINYINT NOT NULL DEFAULT -1,
  released_year SMALLINT NOT NULL DEFAULT -1,
  listed_release_date VARCHAR(255),
  is_master BOOLEAN,
  master_id INTEGER CONSTRAINT fk_release_master_id_master REFERENCES master,
  notes TEXT,
  status VARCHAR(255),
  title VARCHAR(10000)
);

CREATE TABLE IF NOT EXISTS release_genre (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_genre_release_id_release REFERENCES release,
  genre VARCHAR(255) NOT NULL CONSTRAINT fk_release_genre_genre_genre REFERENCES genre,
  PRIMARY KEY (release_id, genre)
);

CREATE TABLE IF NOT EXISTS release_track (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_track_release_id_release REFERENCES release,
  title_duration_position_hash INTEGER NOT NULL,
  duration VARCHAR(1500),
  position VARCHAR(1500),
  title VARCHAR(10000),
  PRIMARY KEY (release_id, title_duration_position_hash)
);

CREATE TABLE IF NOT EXISTS label_release (
  label_id INTEGER NOT NULL CONSTRAINT fk_label_release_label_id_label REFERENCES label,
  release_id INTEGER NOT NULL CONSTRAINT fk_label_release_release_id_release REFERENCES release,
  category_notation VARCHAR(1000),
  PRIMARY KEY (label_id, release_id)
);

CREATE TABLE IF NOT EXISTS release_image (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_image_release_id_release REFERENCES release,
  url_hash INTEGER NOT NULL,
  url VARCHAR(2048) NOT NULL,
  PRIMARY KEY (release_id, url_hash)
);

CREATE TABLE IF NOT EXISTS release_contract (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_contract_release_id_release REFERENCES release,
  label_id INTEGER NOT NULL CONSTRAINT fk_release_contract_label_id_label REFERENCES label,
  contract_hash INTEGER NOT NULL,
  contract VARCHAR(5000) NOT NULL,
  PRIMARY KEY (release_id, label_id, contract_hash)
);

CREATE TABLE IF NOT EXISTS release_identifier (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_identifier_release_id_release REFERENCES release,
  type_value_description_hash INTEGER NOT NULL,
  description VARCHAR(20000),
  type VARCHAR(2500),
  value VARCHAR(20000),
  PRIMARY KEY (release_id, type_value_description_hash)
);

CREATE TABLE IF NOT EXISTS master_video (
  master_id INTEGER NOT NULL CONSTRAINT fk_master_video_master_id_master REFERENCES master,
  title_description_url_hash INTEGER NOT NULL,
  description VARCHAR(4000),
  title VARCHAR(1000),
  url VARCHAR(2048) NOT NULL,
  PRIMARY KEY (master_id, title_description_url_hash)
);

CREATE TABLE IF NOT EXISTS master_genre (
  master_id INTEGER NOT NULL CONSTRAINT fk_master_genre_master_id_master REFERENCES master,
  genre VARCHAR(255) NOT NULL CONSTRAINT fk_master_genre_genre_genre REFERENCES genre,
  PRIMARY KEY (master_id, genre)
);

CREATE TABLE IF NOT EXISTS master_style (
  master_id INTEGER NOT NULL CONSTRAINT fk_master_style_master_id_master REFERENCES master,
  style VARCHAR(255) NOT NULL CONSTRAINT fk_master_style_style_style REFERENCES style,
  PRIMARY KEY (master_id, style)
);

CREATE TABLE IF NOT EXISTS release_style (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_style_release_id_release REFERENCES release,
  style VARCHAR(255) NOT NULL CONSTRAINT fk_release_style_style_style REFERENCES style,
  PRIMARY KEY (release_id, style)
);

CREATE TABLE IF NOT EXISTS release_video (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_video_release_id_release REFERENCES release,
  description VARCHAR(4000),
  title VARCHAR(1000),
  url VARCHAR(2048) NOT NULL,
  title_description_url_hash INTEGER NOT NULL,
  PRIMARY KEY (release_id, title_description_url_hash)
);

CREATE TABLE IF NOT EXISTS label_url (
  label_id INTEGER NOT NULL CONSTRAINT fk_label_url_label_id_label REFERENCES label,
  url_hash INTEGER NOT NULL,
  url VARCHAR(2048) NOT NULL,
  PRIMARY KEY (label_id, url_hash)
);

CREATE TABLE IF NOT EXISTS release_format (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_format_release_id_release REFERENCES release,
  name_description_quantity_content_TEXT_hash INTEGER NOT NULL,
  description VARCHAR(10000),
  name VARCHAR(255),
  quantity INTEGER,
  text VARCHAR(5000),
  PRIMARY KEY (release_id, name_description_quantity_content_TEXT_hash)
);

CREATE TABLE IF NOT EXISTS artist_alias (
  artist_id INTEGER NOT NULL CONSTRAINT fk_artist_alias_artist_id_artist REFERENCES artist,
  alias_id INTEGER NOT NULL CONSTRAINT fk_artist_alias_alias_id_artist REFERENCES artist,
  PRIMARY KEY (artist_id, alias_id)
);

CREATE TABLE IF NOT EXISTS artist_name_variation (
  artist_id INTEGER NOT NULL CONSTRAINT fk_artist_name_variation_artist_id_artist REFERENCES artist,
  name_variation VARCHAR(2000) NOT NULL,
  name_variation_hash INTEGER NOT NULL,
  PRIMARY KEY (artist_id, name_variation_hash)
);

CREATE TABLE IF NOT EXISTS master_artist (
  artist_id INTEGER NOT NULL CONSTRAINT fk_master_artist_artist_id_artist REFERENCES artist,
  master_id INTEGER NOT NULL CONSTRAINT fk_master_artist_master_id_master REFERENCES master,
  PRIMARY KEY (master_id, artist_id)
);

CREATE TABLE IF NOT EXISTS release_artist (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_artist_release_id_release REFERENCES release,
  artist_id INTEGER NOT NULL CONSTRAINT fk_release_artist_artist_id_artist REFERENCES artist,
  PRIMARY KEY (release_id, artist_id)
);

CREATE TABLE IF NOT EXISTS release_credited_artist (
  release_id INTEGER NOT NULL CONSTRAINT fk_release_credited_artist_release_id_release REFERENCES release,
  artist_id INTEGER NOT NULL CONSTRAINT fk_release_credited_artist_artist_id_artist REFERENCES artist,
  role_hash INTEGER NOT NULL,
  role VARCHAR(10000),
  PRIMARY KEY (release_id, artist_id, role_hash)
);

CREATE TABLE IF NOT EXISTS artist_url (
  artist_id INTEGER NOT NULL CONSTRAINT fk_artist_url_artist_id_artist REFERENCES artist,
  url_hash INTEGER NOT NULL,
  url VARCHAR(2048) NOT NULL,
  PRIMARY KEY (artist_id, url_hash)
);

CREATE TABLE IF NOT EXISTS artist_group (
  artist_id INTEGER NOT NULL CONSTRAINT fk_artist_group_artist_id_artist REFERENCES artist,
  group_id INTEGER NOT NULL CONSTRAINT fk_artist_group_group_id_artist REFERENCES artist,
  PRIMARY KEY (artist_id, group_id)
);
