create table ARTISTS_LINKS
(
    id                int auto_increment
        primary key,
    music_artists_id  int                                 null,
    name              varchar(50)                         null,
    type              varchar(50)                         null,
    url               text                                not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table CLOUD_ARTISTS
(
    sort1A           int                                 not null,
    artistID         int                                 not null
        primary key,
    artist_name      text                                not null,
    artist_file_name text                                not null,
    AFN_defined      tinyint(1)                          not null,
    genres           text                                not null,
    created          timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    updated          timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    website          text                                not null,
    deals            int                                 not null,
    ST_office        text                                not null,
    active           tinyint(1)                          not null,
    external         tinyint(1)                          not null,
    SPLIT_MO         date                                not null,
    RA_QTY           tinyint                             not null,
    RA_EMAILS        text                                not null,
    RA1              text                                not null,
    RA1OFF           text                                not null,
    RA1EMAIL         text                                not null,
    RA1TZ            text                                not null,
    RA2              text                                not null,
    RA2OFF           text                                not null,
    RA2EMAIL         text                                not null,
    RA2TZ            text                                not null,
    RA3              text                                not null,
    RA3OFF           text                                not null,
    RA3EMAIL         text                                not null,
    RA3TZ            text                                not null,
    RA4              text                                not null,
    RA4OFF           text                                not null,
    RA4EMAIL         text                                not null,
    RA4TZ            text                                not null,
    sort1B           int                                 not null
)
    charset = utf8;

create table JOBS
(
    id                int auto_increment
        primary key,
    location_id       int                                 not null,
    name              text                                not null,
    posted_on         timestamp                           null,
    description       text                                not null,
    url               text                                not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table LOCATIONS
(
    id                int auto_increment
        primary key,
    region_id         int                                  not null,
    name              text                                 not null,
    address1          text                                 not null,
    address2          text                                 not null,
    city              text                                 not null,
    state             text                                 not null,
    postal            text                                 not null,
    postal_extended   text                                 not null,
    map_image_url     text                                 not null,
    map_url           text                                 not null,
    telephone         text                                 not null,
    fax               text                                 not null,
    showHome          tinyint(1) default 0                 not null,
    deleted           timestamp                            null,
    last_updated_date timestamp  default CURRENT_TIMESTAMP not null,
    last_updated_user int                                  null
)
    charset = utf8;

create table MEDIA
(
    id                int auto_increment
        primary key,
    old_media_id      varchar(50)                         null,
    s3_bucket         varchar(65)                         not null,
    s3_path           text                                not null,
    s3_key            text                                not null,
    type              varchar(10)                         not null,
    mime_type         varchar(20)                         not null,
    height            int(5)                              null,
    width             int(5)                              null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null,
    created_date      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
    charset = utf8;

create table PAGE_CONTENT
(
    id                int auto_increment
        primary key,
    slug              varchar(50)                         null,
    name              varchar(50)                         null,
    content           text                                not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table RECORD_LABELS
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    slug              varchar(50)                         null,
    url               text                                not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table REGIONS
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    featured_rank     tinyint                             not null,
    deleted_at        datetime                            null,
    created_at        datetime                            null,
    updated_at        datetime                            null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table STATUSES
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    slug              varchar(50)                         null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table TERRITORIES
(
    id                int auto_increment
        primary key,
    name              varchar(50)                         not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table TERRITORIES_ARTISTS
(
    id                int auto_increment
        primary key,
    territories_id    int                                 not null,
    artist_id         int                                 not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table TRIBES_ARTISTS
(
    id                int auto_increment
        primary key,
    tribes_id         int                                 not null,
    artist_id         int                                 not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table agencies
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table agency_news_clients_music_deleteme
(
    id               int(11) unsigned auto_increment
        primary key,
    agency_news_id   int(11) unsigned not null,
    clients_music_id int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table agency_news_deleteme
(
    id                  int(11) unsigned auto_increment
        primary key,
    name                varchar(255)     null,
    content             text             null,
    agency_news_type_id int(11) unsigned null,
    submitted_by        int(11) unsigned null,
    main_image          text             null,
    tags                text             null,
    source              text             null,
    music_type          tinyint(1)       null,
    talent_type         tinyint(1)       null,
    deleted_at          datetime         null,
    updated_at          datetime         not null,
    created_at          datetime         not null
)
    charset = utf8;

create table agency_news_types_deleteme
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table ages
(
    id         int auto_increment
        primary key,
    name       varchar(50) null,
    deleted    timestamp   null,
    updated_at datetime    null,
    created_at datetime    null
)
    charset = utf8;

create table announcements
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned     not null,
    title            varchar(255)         null,
    description      text                 null,
    more_link        text                 null,
    homepage_only    tinyint(1) default 0 null,
    user_dismissible tinyint(1) default 0 null,
    start_at         datetime             null,
    end_at           datetime             null,
    created_at       datetime             null,
    updated_at       datetime             null,
    deleted_at       datetime             null
)
    charset = utf8;

create table ar_comments
(
    id             int(11) unsigned auto_increment
        primary key,
    ar_pursuits_id int(11) unsigned not null,
    users_id       int(11) unsigned null,
    comment        text             null,
    deleted_at     datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table ar_pursuits
(
    id                  int(11) unsigned auto_increment
        primary key,
    current_ar_status   int(11) unsigned null,
    name                varchar(255)     null,
    clients_music_id    int(11) unsigned null,
    relation_id         int(11) unsigned null,
    agencies_id         int(11) unsigned null,
    is_sensitive        tinyint(1)       null,
    is_sensitive_reason varchar(255)     null,
    website             varchar(255)     null,
    facebook            varchar(255)     null,
    twitter             varchar(255)     null,
    soundcloud          varchar(255)     null,
    youtube             varchar(255)     null,
    instagram           varchar(255)     null,
    spotify             text             null,
    artist_team         text             null,
    background          text             null,
    press_links         text             null,
    main_image          text             null,
    old_intranet_id     int(11) unsigned null,
    deleted_at          datetime         null,
    updated_at          datetime         null,
    created_at          datetime         null
)
    charset = utf8;

create table ar_pursuits_genres
(
    id             int(11) unsigned auto_increment
        primary key,
    ar_pursuits_id int(11) unsigned not null,
    genres_id      int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table ar_pursuits_tribes
(
    id             int(11) unsigned auto_increment
        primary key,
    ar_pursuits_id int(11) unsigned not null,
    tribes_id      int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table ar_pursuits_users
(
    id             int(11) unsigned auto_increment
        primary key,
    ar_pursuits_id int(11) unsigned not null,
    users_id       int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table ar_status_logs
(
    id                  int(11) unsigned auto_increment
        primary key,
    ar_pursuits_id      int(11) unsigned not null,
    ar_statuses_id      int(11) unsigned not null,
    users_id            int(11) unsigned null,
    updated_by_users_id int(11) unsigned null,
    comment             text             null,
    deleted_at          datetime         null,
    updated_at          datetime         null,
    created_at          datetime         null
)
    charset = utf8;

create table ar_statuses
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table audit_log
(
    id         int(11) unsigned auto_increment
        primary key,
    user_id    int(11) unsigned null,
    content    text             null,
    deleted_at datetime         null,
    updated_at datetime         not null,
    created_at datetime         not null
)
    charset = utf8;

create table audit_log_views
(
    id         int(11) unsigned auto_increment
        primary key,
    user_id    int(11) unsigned null,
    user_name  text             null,
    url        text             null,
    ip_address varchar(45)      null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table avails
(
    id                 int(11) unsigned auto_increment
        primary key,
    clients_music_id   int(11) unsigned null,
    external_artist    text             null,
    external_agency    text             null,
    external_agent     text             null,
    venue_size_min     int(11) unsigned null,
    venue_size_max     int(11) unsigned null,
    budget_min         double           null,
    budget_max         double           null,
    notes              text             null,
    target_start_date  date             null,
    target_end_date    date             null,
    event              text             null,
    venues             text             null,
    avails_statuses_id int(11) unsigned null,
    promoters          text             null,
    promoter_email     text             null,
    promoter_company   text             null,
    confirmed_support  text             null,
    target_announce    date             null,
    target_on_sale     date             null,
    target_2015_q1     tinyint(1)       null,
    target_2015_q2     tinyint(1)       null,
    target_2015_q3     tinyint(1)       null,
    target_2015_q4     tinyint(1)       null,
    target_2016_q1     tinyint(1)       null,
    target_2016_q2     tinyint(1)       null,
    target_2016_q3     tinyint(1)       null,
    target_2016_q4     tinyint(1)       null,
    target_2017_q1     tinyint(1)       null,
    target_2017_q2     tinyint(1)       null,
    target_2017_q3     tinyint(1)       null,
    target_2017_q4     tinyint(1)       null,
    target_2018_q1     tinyint(1)       null,
    target_2018_q2     tinyint(1)       null,
    target_2018_q3     tinyint(1)       null,
    target_2018_q4     tinyint(1)       null,
    target_2019_q1     tinyint(1)       null,
    target_2019_q2     tinyint(1)       null,
    target_2019_q3     tinyint(1)       null,
    target_2019_q4     tinyint(1)       null,
    target_2020_q1     tinyint(1)       null,
    target_2020_q2     tinyint(1)       null,
    target_2020_q3     tinyint(1)       null,
    target_2020_q4     tinyint(1)       null,
    closed_at          datetime         null,
    created_at         datetime         null,
    updated_at         datetime         null,
    deleted_at         datetime         null
)
    charset = utf8;

create table avails_avails_regions
(
    id                int(11) unsigned auto_increment
        primary key,
    avails_id         int(11) unsigned not null,
    avails_regions_id int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table avails_avails_types
(
    id              int(11) unsigned auto_increment
        primary key,
    avails_id       int(11) unsigned not null,
    avails_types_id int(11) unsigned not null,
    created_at      datetime         null,
    updated_at      datetime         null,
    deleted_at      datetime         null
)
    charset = utf8;

create table avails_genres
(
    id         int(11) unsigned auto_increment
        primary key,
    avails_id  int(11) unsigned not null,
    genres_id  int(11) unsigned not null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table avails_regions
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    `order`    tinyint      null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table avails_statuses
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table avails_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    `order`    tinyint      null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table avails_users
(
    id         int(11) unsigned auto_increment
        primary key,
    avails_id  int(11) unsigned not null,
    users_id   int(11) unsigned not null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table books
(
    id                int auto_increment
        primary key,
    media_id          varchar(1088)        not null,
    featured_rank     tinyint    default 0 not null,
    display_public    tinyint(1) default 0 not null,
    display_intranet  tinyint(1) default 1 not null,
    bestseller        tinyint(1) default 1 not null,
    name              text                 not null,
    author            text                 not null,
    description       text                 not null,
    url               text                 not null,
    released_date     date                 null,
    deleted_at        datetime             null,
    updated_at        datetime             null,
    created_at        datetime             null,
    last_updated_user int                  null
)
    charset = utf8;

create table branding
(
    id            int(11) unsigned auto_increment
        primary key,
    name          varchar(255)  null,
    description   text          null,
    file_path     text          null,
    display_order int default 1 null,
    created_at    datetime      null,
    updated_at    datetime      null,
    deleted_at    datetime      null
)
    charset = utf8;

create table branding_files
(
    id                  int(11) unsigned auto_increment
        primary key,
    branding_id         int(11) unsigned not null,
    name                varchar(255)     null,
    file_path           text             null,
    thumbnail_file_path text             null,
    featured_rank       int              not null,
    created_at          datetime         null,
    updated_at          datetime         null,
    deleted_at          datetime         null
)
    charset = utf8;

create table brands
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    slug       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table cache
(
    `key`      varchar(255) collate utf8mb4_unicode_ci not null,
    value      text collate utf8mb4_unicode_ci         not null,
    expiration int                                     not null,
    constraint `key`
        unique (`key`)
)
    charset = utf8;

create table calendars
(
    id          int(11) unsigned auto_increment
        primary key,
    name        varchar(255) null,
    slug        varchar(255) null,
    url         text         null,
    music_type  tinyint(1)   null,
    talent_type tinyint(1)   null,
    created_at  datetime     null,
    updated_at  datetime     null,
    deleted_at  datetime     null
)
    charset = utf8;

create table calendars_events
(
    id            int(11) unsigned auto_increment
        primary key,
    calendars_id  varchar(255) null,
    summary       text         null,
    dtstart       datetime     null,
    dtend         datetime     null,
    all_day_event tinyint(1)   null,
    dtstamp       datetime     null,
    uid           varchar(255) null,
    created       datetime     null,
    description   text         null,
    status        varchar(255) null,
    music_type    tinyint(1)   null,
    talent_type   tinyint(1)   null,
    created_at    datetime     null,
    updated_at    datetime     null,
    deleted_at    datetime     null
)
    charset = utf8;

create table categories
(
    id            int auto_increment
        primary key,
    name          varchar(50) null,
    featured_rank tinyint     not null,
    deleted       timestamp   null,
    updated_at    datetime    null,
    created_at    datetime    null
)
    charset = utf8;

create table clients
(
    id                           int auto_increment
        primary key,
    slug                         varchar(255) null,
    name                         text         not null,
    country_of_origin_DO_NOT_USE int          null,
    url                          text         not null,
    bio                          text         not null,
    bio_updated_at               datetime     null,
    last_updated_bio             timestamp    null,
    deleted                      timestamp    null,
    created_at                   datetime     null,
    updated_at                   datetime     null,
    last_updated_user            int          null,
    alphabet_sort                varchar(100) not null,
    old_intranet_id              int unsigned null,
    wikipedia                    text         null
)
    charset = utf8;

create table clients_comedy
(
    id                      int auto_increment
        primary key,
    clients_id              int                  null,
    slug                    varchar(255)         null,
    display_public          tinyint(1) default 0 not null,
    display_intranet        tinyint(1) default 1 not null,
    name                    text                 not null,
    start_date              date                 null,
    inactive_date           date                 null,
    next_big_sound_id       varchar(255)         null,
    soundcloud              text                 not null,
    youtube                 text                 not null,
    twitter                 text                 not null,
    facebook                text                 not null,
    instagram               text                 not null,
    spotify                 text                 null,
    bandsintown             text                 null,
    main_image              text                 null,
    last_updated_photo      timestamp            null,
    last_updated_user       int                  null,
    alphabet_sort           varchar(100)         null,
    contact_emails          text                 null,
    territory_combined      int unsigned         null,
    corporate_roster        tinyint(1)           null,
    assets_password         varchar(255)         null,
    public_website_caption  varchar(255)         null,
    do_not_show_global_icon tinyint(1)           null,
    deleted_at              datetime             null,
    created_at              datetime             not null,
    updated_at              datetime             not null
)
    charset = utf8;

create table clients_comedy_agencies
(
    id                int auto_increment
        primary key,
    clients_comedy_id int                  not null,
    agencies_id       int                  not null,
    dormant_date      date                 null,
    north_america     tinyint(1) default 0 not null,
    usa               tinyint(1) default 0 not null,
    canada            tinyint(1) default 0 not null,
    carribean         tinyint(1) default 0 not null,
    mexico            tinyint(1) default 0 not null,
    south_america     tinyint(1) default 0 not null,
    europe            tinyint(1) default 0 not null,
    asia              tinyint(1) default 0 not null,
    middle_east       tinyint(1) default 0 not null,
    australia         tinyint(1) default 0 not null,
    africa            tinyint(1) default 0 not null,
    territory_notes   text                 null
)
    charset = utf8;

create table clients_comedy_assets
(
    id                    int unsigned auto_increment
        primary key,
    clients_comedy_id     int(10)              not null,
    media_id              varchar(1024)        not null,
    featured_rank         int                  not null,
    display_public        tinyint(1) default 0 not null,
    display_intranet      tinyint(1) default 0 not null,
    public_download       tinyint(1) default 0 not null,
    public_download_title varchar(100)         not null,
    deleted               tinyint(1)           null,
    updated_at            datetime             not null,
    last_updated_user     int unsigned         null,
    created_at            datetime             not null,
    deleted_at            datetime             null
)
    charset = utf8;

create table clients_comedy_genres
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_comedy_id int(11) unsigned not null,
    comedy_genres_id  int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_comedy_media_embeds
(
    id                            int(11) unsigned auto_increment
        primary key,
    clients_comedy_id             int(11) unsigned     not null,
    name                          varchar(255)         null,
    content                       text                 null,
    link                          text                 null,
    embed_code                    text                 null,
    homepage_media_embeds_type_id int(11) unsigned     null,
    display_order                 tinyint              null,
    display_public                tinyint(1) default 0 not null,
    created_at                    datetime             null,
    updated_at                    datetime             null,
    deleted_at                    datetime             null
)
    charset = utf8;

create table clients_comedy_users
(
    id                int auto_increment
        primary key,
    users_id          int                                 null,
    clients_comedy_id int                                 not null,
    roles_id          int                                 null,
    `order`           int       default 0                 null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null,
    temp_node_id      int(11) unsigned                    null
)
    charset = utf8;

create table clients_contacts
(
    id               int auto_increment
        primary key,
    clients_id       int  not null,
    contacts_id      int  not null,
    contact_types_id int  not null,
    companies_id     int  not null,
    notes            text not null
)
    charset = utf8;

create table clients_countries_of_origin
(
    id           int(11) unsigned auto_increment
        primary key,
    clients_id   int      not null,
    countries_id int      not null,
    created_at   datetime not null,
    updated_at   datetime not null,
    deleted_at   datetime null
)
    charset = utf8;

create table clients_lit
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_id       int(11) unsigned     not null,
    first_name       varchar(255)         null,
    last_name        varchar(255)         null,
    slug             varchar(255)         null,
    featured_rank    tinyint              null,
    display_public   tinyint(1) default 0 null,
    display_intranet tinyint(1) default 0 null,
    main_image       text                 null,
    loan_out         tinyint(1) default 0 not null,
    genders_id       int                  null,
    based_in         varchar(255)         null,
    ethnicity_note   text                 null,
    training         text                 null,
    visas            text                 null,
    visas_notes      text                 null,
    valid_passport   text                 null,
    availability     text                 null,
    agent_team_notes text                 null,
    current_project  text                 null,
    network          text                 null,
    imdb             text                 null,
    studio_sys       text                 null,
    credits          text                 null,
    writing_team     text                 null,
    management       text                 null,
    other_notes      text                 null,
    music            tinyint(1) default 0 null,
    actor            tinyint(1) default 0 null,
    confirmed        tinyint(1) default 0 null,
    inactive_date    datetime             null,
    created_at       datetime             null,
    updated_at       datetime             null,
    deleted_at       datetime             null
)
    charset = utf8;

create table clients_lit_areas
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    lit_areas_id   int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_companies
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    companies_id   int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_countries
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    countries_id   int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_ethnicities
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    ethnicities_id int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_genres
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    lit_genres_id  int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table clients_lit_media
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    title          varchar(255)     null,
    link           varchar(255)     null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_media_pages
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned     not null,
    title          text                 null,
    bio            text                 null,
    credits        text                 null,
    main_video     text                 null,
    main_image     text                 null,
    expires        datetime             null,
    download       tinyint(1) default 0 not null,
    branding       tinyint(1) default 0 not null,
    password       text                 null,
    slug           varchar(255)         not null,
    display_public tinyint(1) default 0 not null,
    deleted_at     datetime             null,
    updated_at     datetime             not null,
    created_at     datetime             not null
)
    charset = utf8;

create table clients_lit_types
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    lit_types_id   int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_lit_users
(
    id             int(11) unsigned auto_increment
        primary key,
    clients_lit_id int(11) unsigned not null,
    users_id       int(11) unsigned not null,
    type           int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table clients_music
(
    id                            int auto_increment
        primary key,
    clients_id                    int                  null,
    slug                          varchar(255)         null,
    featured_rank                 tinyint    default 0 null,
    display_public                tinyint(1) default 0 not null,
    display_intranet              tinyint(1) default 1 not null,
    name                          text                 not null,
    territory_notes               text                 null,
    amonly_artist_id              int                  null,
    paradigm_artist_id            varchar(8)           null,
    statuses_id                   int                  null,
    power_of_attorney             text                 null,
    start_date                    date                 null,
    inactive_date                 date                 null,
    dormant_date                  date                 null,
    legal_name                    text                 null,
    date_of_birth                 date                 null,
    visa_expiration_date          date                 null,
    press_pack                    text                 null,
    record_labels_id              int                  null,
    contracting_party_title       text                 null,
    address                       text                 null,
    country_of_furnishing_company int                  null,
    next_big_sound_id             varchar(255)         null,
    soundcloud                    text                 not null,
    youtube                       text                 not null,
    twitter                       text                 not null,
    facebook                      text                 not null,
    instagram                     text                 not null,
    image_gallery                 text                 null,
    gallery_download              text                 null,
    gallery_download_link         text                 null,
    riders_and_admats             text                 null,
    riders_password               text                 null,
    record_label_url              text                 null,
    publicity                     text                 null,
    embedded_media                text                 null,
    main_image                    text                 null,
    last_updated_photo            timestamp            null,
    special_availability          text                 null,
    deleted_at                    datetime             null,
    created_at                    datetime             not null,
    updated_at                    datetime             not null,
    last_updated_user             int                  null,
    cloud_artist_id               int                  null,
    ca_cloud_artist_id            int                  null,
    vevo                          text                 not null,
    snapchat                      text                 not null,
    spotify                       text                 null,
    bandsintown                   text                 null,
    windish_id                    int                  null,
    alphabet_sort                 varchar(100)         null,
    old_intranet_id               int unsigned         null,
    coda_id                       int                  null,
    contact_emails                text                 null,
    contact_emails_europe         text                 null,
    territory_combined            int unsigned         null,
    corporate_roster              tinyint(1)           null,
    dj                            tinyint(1)           null,
    live                          tinyint(1)           null,
    assets_password               varchar(255)         null,
    public_website_caption        varchar(255)         null,
    do_not_show_global_icon       tinyint(1) default 0 not null,
    genre_id_primary              int(11) unsigned     null,
    recent_signings_date          date                 null
)
    charset = utf8;

create table clients_music_agencies
(
    id               int auto_increment
        primary key,
    clients_music_id int                  not null,
    agencies_id      int                  not null,
    dormant_date     date                 null,
    start_date       date                 null,
    usa              tinyint(1) default 0 not null,
    canada           tinyint(1) default 0 not null,
    carribean        tinyint(1) default 0 not null,
    mexico           tinyint(1) default 0 not null,
    south_america    tinyint(1) default 0 not null,
    europe           tinyint(1) default 0 not null,
    asia             tinyint(1) default 0 not null,
    middle_east      tinyint(1) default 0 not null,
    australia        tinyint(1) default 0 not null,
    africa           tinyint(1) default 0 not null,
    territory_notes  text                 null,
    temp_node_id     int                  null
)
    charset = utf8;

create table clients_music_assets
(
    id                    int unsigned auto_increment
        primary key,
    clients_music_id      int(10)              not null,
    media_id              varchar(1024)        not null,
    featured_rank         int                  not null,
    display_public        tinyint(1) default 0 not null,
    display_intranet      tinyint(1) default 0 not null,
    public_download       tinyint(1) default 0 not null,
    public_download_title varchar(100)         not null,
    deleted               tinyint(1)           null,
    updated_at            datetime             not null,
    last_updated_user     int unsigned         null,
    created_at            datetime             not null,
    deleted_at            datetime             null
)
    charset = utf8;

create table clients_music_ca_cloud_artist_id
(
    id                 int(11) unsigned auto_increment
        primary key,
    clients_music_id   int(11) unsigned not null,
    ca_cloud_artist_id int(11) unsigned not null,
    created_at         datetime         null,
    updated_at         datetime         null,
    deleted_at         datetime         null
)
    charset = utf8;

create table clients_music_cloud_artist_id
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned not null,
    cloud_artist_id  int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table clients_music_coda_id
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned not null,
    coda_id          int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table clients_music_corporate_resources
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned not null,
    name             varchar(255)     null,
    link             varchar(255)     null,
    password         varchar(255)     null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table clients_music_genres
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned not null,
    genres_id        int(11) unsigned not null,
    deleted          datetime         null,
    updated_at       datetime         null,
    created_at       datetime         null
)
    charset = utf8;

create table clients_music_media
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_music_id int(11) unsigned     not null,
    media_id         text                 null,
    embed_code       text                 null,
    display_order    tinyint              null,
    display_public   tinyint(1) default 0 not null,
    created_at       datetime             null,
    updated_at       datetime             null,
    deleted_at       datetime             null
)
    charset = utf8;

create table clients_music_media_embeds
(
    id                            int(11) unsigned auto_increment
        primary key,
    clients_music_id              int(11) unsigned     not null,
    name                          varchar(255)         null,
    content                       text                 null,
    link                          text                 null,
    embed_code                    text                 null,
    homepage_media_embeds_type_id int(11) unsigned     null,
    display_order                 tinyint              null,
    display_public                tinyint(1) default 0 not null,
    created_at                    datetime             null,
    updated_at                    datetime             null,
    deleted_at                    datetime             null
)
    charset = utf8;

create table clients_music_users
(
    id                int auto_increment
        primary key,
    users_id          int                                 null,
    clients_music_id  int                                 not null,
    roles_id          int                                 null,
    `order`           int       default 0                 null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null,
    temp_node_id      int(11) unsigned                    null
)
    charset = utf8;

create table clients_music_videos
(
    id                 int unsigned auto_increment
        primary key,
    title              text                 null,
    description        text                 null,
    music_artist_id    int unsigned         not null,
    media_id           varchar(1024)        not null,
    thumbnail_media_id varchar(1024)        not null,
    expires            datetime             null,
    download           tinyint(1) default 0 not null,
    branding           tinyint(1) default 0 not null,
    password           text                 null,
    slug               varchar(50)          not null,
    display_public     tinyint(1) default 0 not null,
    deleted            datetime             null,
    updated_at         datetime             not null,
    created_at         datetime             not null
)
    charset = utf8;

create table clients_talent
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_id       int                  null,
    name             varchar(255)         null,
    slug             varchar(255)         null,
    featured_rank    tinyint              null,
    display_public   tinyint(1) default 0 null,
    display_intranet tinyint(1) default 0 null,
    main_image       text                 null,
    youth            tinyint(1) default 0 not null,
    loan_out         tinyint(1) default 0 not null,
    height           int                  null,
    genders_id       int                  null,
    based_in         varchar(255)         null,
    ethnicity_note   text                 null,
    skills_notes     text                 null,
    training         text                 null,
    visas            text                 null,
    visas_notes      text                 null,
    valid_passport   text                 null,
    availability     text                 null,
    avail_pilots     tinyint(1) default 0 null,
    agent_team_notes text                 null,
    current_tv       text                 null,
    network          text                 null,
    imdb             text                 null,
    credits          text                 null,
    youtube          text                 null,
    twitter          text                 null,
    facebook         text                 null,
    instagram        text                 null,
    soundcloud       text                 null,
    spotify          text                 null,
    inactive_date    datetime             null,
    created_at       datetime             null,
    updated_at       datetime             null,
    deleted_at       datetime             null
)
    charset = utf8;

create table clients_talent_ages
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    talent_ages_id    int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_countries
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    countries_id      int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_ethnicities
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    ethnicities_id    int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_languages
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    languages_id      int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_locations
(
    id                  int(11) unsigned auto_increment
        primary key,
    clients_talent_id   int(11) unsigned not null,
    talent_locations_id int(11) unsigned not null,
    created_at          datetime         null,
    updated_at          datetime         null,
    deleted_at          datetime         null
)
    charset = utf8;

create table clients_talent_media
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    title             varchar(255)     null,
    link              varchar(255)     null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_media_pages
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned     not null,
    title             text                 null,
    bio               text                 null,
    credits           text                 null,
    main_video        text                 null,
    main_image        text                 null,
    expires           datetime             null,
    download          tinyint(1) default 0 not null,
    branding          tinyint(1) default 0 not null,
    password          text                 null,
    slug              varchar(255)         not null,
    display_public    tinyint(1) default 0 not null,
    deleted_at        datetime             null,
    updated_at        datetime             not null,
    created_at        datetime             not null
)
    charset = utf8;

create table clients_talent_skills
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    talent_skills_id  int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_types
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    talent_types_id   int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_talent_users
(
    id                int(11) unsigned auto_increment
        primary key,
    clients_talent_id int(11) unsigned not null,
    users_id          int(11) unsigned not null,
    type              int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table clients_unscripted
(
    id               int(11) unsigned auto_increment
        primary key,
    clients_id       int(11) unsigned     not null,
    first_name       varchar(255)         null,
    last_name        varchar(255)         null,
    slug             varchar(255)         null,
    featured_rank    tinyint              null,
    display_public   tinyint(1) default 0 null,
    display_intranet tinyint(1) default 0 null,
    main_image       text                 null,
    genders_id       int                  null,
    based_in         varchar(255)         null,
    other_notes      text                 null,
    imdb             text                 null,
    credit_1         varchar(255)         null,
    credit_2         varchar(255)         null,
    credit_3         varchar(255)         null,
    inactive_date    datetime             null,
    created_at       datetime             null,
    updated_at       datetime             null,
    deleted_at       datetime             null
)
    charset = utf8;

create table clients_unscripted_companies
(
    id                    int(11) unsigned auto_increment
        primary key,
    clients_unscripted_id int(11) unsigned not null,
    companies_id          int(11) unsigned not null,
    created_at            datetime         null,
    updated_at            datetime         null,
    deleted_at            datetime         null
)
    charset = utf8;

create table clients_unscripted_ethnicities
(
    id                    int(11) unsigned auto_increment
        primary key,
    clients_unscripted_id int(11) unsigned not null,
    ethnicities_id        int(11) unsigned not null,
    created_at            datetime         null,
    updated_at            datetime         null,
    deleted_at            datetime         null
)
    charset = utf8;

create table clients_unscripted_genres
(
    id                    int(11) unsigned auto_increment
        primary key,
    clients_unscripted_id int(11) unsigned not null,
    unscripted_genres_id  int(11) unsigned not null,
    deleted               datetime         null,
    updated_at            datetime         null,
    created_at            datetime         null
)
    charset = utf8;

create table clients_unscripted_types
(
    id                    int(11) unsigned auto_increment
        primary key,
    clients_unscripted_id int(11) unsigned not null,
    unscripted_types_id   int(11) unsigned not null,
    created_at            datetime         null,
    updated_at            datetime         null,
    deleted_at            datetime         null
)
    charset = utf8;

create table clients_unscripted_users
(
    id                    int(11) unsigned auto_increment
        primary key,
    clients_unscripted_id int(11) unsigned not null,
    users_id              int(11) unsigned not null,
    type                  int(11) unsigned not null,
    created_at            datetime         null,
    updated_at            datetime         null,
    deleted_at            datetime         null
)
    charset = utf8;

create table clients_voiceover
(
    id               int auto_increment
        primary key,
    clients_id       int                  null,
    first_name       text                 not null,
    last_name        text                 not null,
    biography        text                 not null,
    gender           tinyint(1)           not null,
    featured_rank    tinyint    default 0 not null,
    display_public   tinyint(1) default 0 not null,
    display_intranet tinyint(1) default 1 not null,
    deleted_at       datetime             null,
    updated_at       datetime             null,
    created_at       datetime             null
)
    charset = utf8;

create table clients_voiceover_ages
(
    id                   int auto_increment
        primary key,
    clients_voiceover_id int       null,
    age_id               int       not null,
    deleted              timestamp null,
    updated_at           datetime  null,
    created_at           datetime  null
)
    charset = utf8;

create table clients_voiceover_categories
(
    id                   int auto_increment
        primary key,
    clients_voiceover_id int           null,
    category_id          int           not null,
    media_id             varchar(1088) not null,
    deleted              timestamp     null,
    updated_at           datetime      null,
    created_at           datetime      null
)
    charset = utf8;

create table clients_voiceover_landing
(
    id                     int auto_increment
        primary key,
    clients_voiceover_id   int       null,
    display_order          int       not null,
    deleted                timestamp null,
    updated_at             datetime  null,
    video_media_id         text      null,
    thumbnail_media_id     text      null,
    thumbnail_media_id_955 text      null,
    thumbnail_media_id_305 text      null,
    title                  text      null,
    created_at             datetime  null
)
    charset = utf8;

create table clients_voiceover_languages
(
    id                   int auto_increment
        primary key,
    clients_voiceover_id int       null,
    language_id          int       not null,
    deleted              timestamp null,
    updated_at           datetime  null,
    created_at           datetime  null
)
    charset = utf8;

create table comedy_genres
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table companies
(
    id               int auto_increment
        primary key,
    company_types_id int          not null,
    name             varchar(255) not null,
    address1         text         not null,
    address2         text         not null,
    city             text         not null,
    state            text         not null,
    country          text         not null,
    zip              text         not null,
    phone            text         not null,
    fax              text         not null,
    url              text         not null,
    created_at       datetime     null,
    updated_at       datetime     null,
    deleted_at       datetime     null
)
    charset = utf8;

create table company_types
(
    id   int auto_increment
        primary key,
    name varchar(255) not null
)
    charset = utf8;

create table configs
(
    id         int(11) unsigned auto_increment
        primary key,
    `key`      varchar(255) not null,
    value      text         null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table contact_types
(
    id   int auto_increment
        primary key,
    name varchar(255) not null
)
    charset = utf8;

create table contacts
(
    id           int auto_increment
        primary key,
    name         varchar(255) not null,
    address1     text         not null,
    address2     text         not null,
    city         text         not null,
    state        text         not null,
    country      text         not null,
    zip          text         not null,
    phone        text         not null,
    fax          text         not null,
    url          text         not null,
    email1       text         not null,
    email2       text         not null,
    main_phone   text         not null,
    mobile_phone text         not null,
    office_phone text         not null,
    created_at   datetime     null,
    updated_at   datetime     null,
    deleted_at   datetime     null
)
    charset = utf8;

create table countries
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    slug              varchar(50)                         null,
    display_order     int       default 1                 null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table departments
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table divisions
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table ethnicities
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    diverse    tinyint      null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table genders
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    slug       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table genres
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    slug       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table homepage_banners
(
    id            int(11) unsigned auto_increment
        primary key,
    name          varchar(255)      null,
    subname       varchar(255)      null,
    main_image    text              null,
    content       text              null,
    link          text              null,
    display_order tinyint default 1 null,
    music_type    tinyint(1)        null,
    talent_type   tinyint(1)        null,
    created_at    datetime          null,
    updated_at    datetime          null,
    deleted_at    datetime          null
)
    charset = utf8;

create table homepage_links
(
    id                      int(11) unsigned auto_increment
        primary key,
    name                    varchar(255)     null,
    url                     text             null,
    music_link              tinyint(1)       null,
    talent_link             tinyint(1)       null,
    homepage_links_types_id int(11) unsigned not null,
    deleted_at              datetime         null,
    updated_at              datetime         not null,
    created_at              datetime         not null
)
    charset = utf8;

create table homepage_links_types
(
    id            int(11) unsigned auto_increment
        primary key,
    name          varchar(255) null,
    display_order tinyint      null,
    deleted_at    datetime     null,
    updated_at    datetime     not null,
    created_at    datetime     not null
)
    charset = utf8;

create table homepage_media_embeds
(
    id                            int(11) unsigned auto_increment
        primary key,
    name                          varchar(255)     null,
    content                       text             null,
    link                          text             null,
    embed_code                    text             null,
    homepage_media_embeds_type_id int(11) unsigned null,
    music_type                    tinyint(1)       null,
    talent_type                   tinyint(1)       null,
    submitted_by                  int(11) unsigned null,
    created_at                    datetime         null,
    updated_at                    datetime         null,
    deleted_at                    datetime         null
)
    charset = utf8;

create table homepage_media_embeds_type
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table languages
(
    id         int auto_increment
        primary key,
    name       varchar(50) null,
    deleted    timestamp   null,
    updated_at datetime    null,
    created_at datetime    null
)
    charset = utf8;

create table leadership
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table lit_areas
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table lit_genres
(
    id                  int(11) unsigned auto_increment
        primary key,
    name                varchar(255) null,
    parent_lit_genre_id int          null,
    deleted             datetime     null,
    updated_at          datetime     null,
    created_at          datetime     null
)
    charset = utf8;

create table lit_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table news
(
    id                       int(11) unsigned auto_increment
        primary key,
    name                     varchar(255)     null,
    content                  text             null,
    main_image               text             null,
    link                     text             null,
    news_type_id             int(11) unsigned null,
    music_type               tinyint(1)       null,
    talent_type              tinyint(1)       null,
    submitted_by             int(11) unsigned null,
    has_active_clients_music tinyint          null,
    created_at               datetime         null,
    updated_at               datetime         null,
    deleted_at               datetime         null
)
    charset = utf8;

create table news_clients_comedy
(
    id                int(11) unsigned auto_increment
        primary key,
    news_id           int(11) unsigned not null,
    clients_comedy_id int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table news_clients_lit
(
    id             int(11) unsigned auto_increment
        primary key,
    news_id        int(11) unsigned not null,
    clients_lit_id int(11) unsigned not null,
    created_at     datetime         null,
    updated_at     datetime         null,
    deleted_at     datetime         null
)
    charset = utf8;

create table news_clients_music
(
    id               int(11) unsigned auto_increment
        primary key,
    news_id          int(11) unsigned not null,
    clients_music_id int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table news_clients_talent
(
    id                int(11) unsigned auto_increment
        primary key,
    news_id           int(11) unsigned not null,
    clients_talent_id int(11) unsigned not null,
    created_at        datetime         null,
    updated_at        datetime         null,
    deleted_at        datetime         null
)
    charset = utf8;

create table news_clients_unscripted
(
    id                    int(11) unsigned auto_increment
        primary key,
    news_id               int(11) unsigned not null,
    clients_unscripted_id int(11) unsigned not null,
    created_at            datetime         null,
    updated_at            datetime         null,
    deleted_at            datetime         null
)
    charset = utf8;

create table news_files
(
    id         int(11) unsigned auto_increment
        primary key,
    news_id    int(11) unsigned not null,
    file_path  text             null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table news_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table news_users
(
    id         int(11) unsigned auto_increment
        primary key,
    news_id    int(11) unsigned not null,
    users_id   int(11) unsigned not null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table office_team
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table opportunities
(
    id                            int(11) unsigned auto_increment
        primary key,
    name                          varchar(255)     null,
    slug                          varchar(255)     null,
    opportunities_types_id        int(11) unsigned null,
    music_opp                     tinyint(1)       null,
    talent_opp                    tinyint(1)       null,
    budget_min                    double           null,
    budget_max                    double           null,
    budget_notes                  text             null,
    date_start                    date             null,
    date_end                      date             null,
    date_notes                    text             null,
    talent_notes                  text             null,
    description                   text             null,
    department_notes              text             null,
    origin                        varchar(255)     null,
    current_opportunities_status  int(11) unsigned null,
    display_outside_department    tinyint(1)       null,
    brands_to_agency_same_as_dept tinyint(1)       null,
    due_date                      date             null,
    created_at                    datetime         null,
    updated_at                    datetime         null,
    deleted_at                    datetime         null
)
    charset = utf8;

create table opportunities_brands
(
    id               int(11) unsigned auto_increment
        primary key,
    opportunities_id int(11) unsigned not null,
    brands_id        int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table opportunities_brands_to_agency
(
    id               int(11) unsigned auto_increment
        primary key,
    opportunities_id int(11) unsigned not null,
    brands_id        int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table opportunities_clients_music
(
    id               int(11) unsigned auto_increment
        primary key,
    opportunities_id int(11) unsigned not null,
    clients_music_id int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table opportunities_companies_contacts
(
    id               int(11) unsigned auto_increment
        primary key,
    opportunities_id int(11) unsigned not null,
    companies_id     int(11) unsigned not null,
    contacts_id      int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table opportunities_permissions_departments
(
    id                     int(11) unsigned auto_increment
        primary key,
    opportunities_types_id int(11) unsigned not null,
    departments_id         int(11) unsigned not null,
    created_at             datetime         null,
    updated_at             datetime         null,
    deleted_at             datetime         null
)
    charset = utf8;

create table opportunities_status_logs
(
    id                        int(11) unsigned auto_increment
        primary key,
    opportunities_id          int(11) unsigned not null,
    opportunities_statuses_id int(11) unsigned not null,
    users_id                  int(11) unsigned not null,
    notes                     text             null,
    next_steps                text             null,
    created_at                datetime         null,
    updated_at                datetime         null,
    deleted_at                datetime         null
)
    charset = utf8;

create table opportunities_statuses
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table opportunities_types
(
    id                                         int(11) unsigned auto_increment
        primary key,
    name                                       varchar(255) null,
    notification_always                        text         null,
    notification_always_bcc                    text         null,
    notification_outside_department_music      text         null,
    notification_outside_department_music_bcc  text         null,
    notification_outside_department_talent     text         null,
    notification_outside_department_talent_bcc text         null,
    deleted_at                                 datetime     null,
    updated_at                                 datetime     not null,
    created_at                                 datetime     not null
)
    charset = utf8;

create table opportunities_users
(
    id               int(11) unsigned auto_increment
        primary key,
    opportunities_id int(11) unsigned not null,
    users_id         int(11) unsigned not null,
    created_at       datetime         null,
    updated_at       datetime         null,
    deleted_at       datetime         null
)
    charset = utf8;

create table pages
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    slug       varchar(255) null,
    content    text         null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table resources
(
    id         int(11) unsigned auto_increment
        primary key,
    name       text         null,
    body       text         null,
    author     int unsigned null,
    promoter   varchar(255) null,
    event      varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table resources_agencies
(
    id           int(11) unsigned auto_increment
        primary key,
    resources_id int(11) unsigned not null,
    agencies_id  int(11) unsigned not null,
    created_at   datetime         null,
    updated_at   datetime         null,
    deleted_at   datetime         null
)
    charset = utf8;

create table resources_files
(
    id           int(11) unsigned auto_increment
        primary key,
    resources_id int(11) unsigned not null,
    file_path    text             null,
    created_at   datetime         null,
    updated_at   datetime         null,
    deleted_at   datetime         null
)
    charset = utf8;

create table resources_permissions
(
    id           int(11) unsigned auto_increment
        primary key,
    resources_id int(11) unsigned null,
    permissions  varchar(45)      null,
    created_at   datetime         null,
    updated_at   datetime         null,
    deleted_at   datetime         null
)
    charset = utf8;

create table resources_resources_types
(
    id                 int(11) unsigned auto_increment
        primary key,
    resources_id       int(11) unsigned not null,
    resources_types_id int(11) unsigned not null,
    created_at         datetime         null,
    updated_at         datetime         null,
    deleted_at         datetime         null
)
    charset = utf8;

create table resources_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table roles
(
    id                int auto_increment
        primary key,
    name              text                                not null,
    slug              varchar(50)                         null,
    deleted           timestamp                           null,
    last_updated_date timestamp default CURRENT_TIMESTAMP not null,
    last_updated_user int                                 null
)
    charset = utf8;

create table sections
(
    id                int(11) unsigned auto_increment
        primary key,
    parent_section_id int(11) unsigned  null,
    section_type      int(11) unsigned  null,
    name              text              null,
    box1_title        text              null,
    box1_content      text              null,
    box2_title        text              null,
    box2_content      text              null,
    display_order     tinyint default 1 null,
    deleted_at        datetime          null,
    updated_at        datetime          not null,
    created_at        datetime          not null
)
    charset = utf8;

create table sections_pages
(
    id            int(11) unsigned auto_increment
        primary key,
    sections_id   int(11) unsigned  not null,
    name          text              null,
    display_order tinyint default 1 null,
    content       text              null,
    created_at    datetime          null,
    updated_at    datetime          null,
    deleted_at    datetime          null
)
    charset = utf8;

create table sections_resources
(
    id           int(11) unsigned auto_increment
        primary key,
    sections_id  int(11) unsigned not null,
    resources_id int(11) unsigned not null,
    created_at   datetime         null,
    updated_at   datetime         null,
    deleted_at   datetime         null
)
    charset = utf8;

create table sections_users
(
    id            int(11) unsigned auto_increment
        primary key,
    sections_id   int(11) unsigned not null,
    users_id      int(11) unsigned not null,
    display_order int              null,
    created_at    datetime         null,
    updated_at    datetime         null,
    deleted_at    datetime         null
)
    charset = utf8;

create table sessions
(
    id            varchar(255) not null,
    user_id       int          null,
    ip_address    varchar(45)  null,
    user_agent    text         null,
    payload       text         not null,
    last_activity int          not null,
    constraint sessions_id_unique
        unique (id)
)
    charset = utf8;

create table social_media_stats
(
    id                int(11) unsigned auto_increment
        primary key,
    next_big_sound_id varchar(255)        not null,
    date_collected    date                null,
    service_name      varchar(255)        null,
    service_id        int(11) unsigned    null,
    profile_url       varchar(255)        null,
    profile_id        int(11) unsigned    null,
    metric            varchar(255)        null,
    metric_value      bigint(21) unsigned null,
    created_at        datetime            null,
    updated_at        datetime            null,
    deleted_at        datetime            null
)
    charset = utf8;

create table social_media_stats_latest
(
    id                 int(11) unsigned auto_increment
        primary key,
    clients_music_id   int              not null,
    next_big_sound_id  varchar(255)     not null,
    date_collected     date             null,
    twitter_fans       int(11) unsigned null,
    twitter_friends    int(11) unsigned null,
    twitter_lists      int(11) unsigned null,
    twitter_statuses   int(11) unsigned null,
    twitter_mentions   int(11) unsigned null,
    facebook_fans      int(11) unsigned null,
    wikipedia_views    int(11) unsigned null,
    youtube_plays      int(11) unsigned null,
    youtube_fans       int(11) unsigned null,
    youtube_likes      int(11) unsigned null,
    youtube_raters     int(11) unsigned null,
    songkick_fans      int(11) unsigned null,
    vevo_plays         int(11) unsigned null,
    instagram_fans     int(11) unsigned null,
    instagram_comments int(11) unsigned null,
    instagram_likes    int(11) unsigned null,
    instagram_friends  int(11) unsigned null,
    instagram_statuses int(11) unsigned null,
    data_json          text             null,
    created_at         datetime         null,
    updated_at         datetime         null,
    deleted_at         datetime         null
)
    charset = utf8;

create table talent_ages
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    sort       int          null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table talent_countries
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table talent_locations
(
    id                  int(11) unsigned auto_increment
        primary key,
    talent_countries_id int(11) unsigned not null,
    city                varchar(255)     null,
    created_at          datetime         null,
    updated_at          datetime         null,
    deleted_at          datetime         null
)
    charset = utf8;

create table talent_skills
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table talent_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table teams
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table tribes
(
    id                  int(11) unsigned auto_increment
        primary key,
    name                varchar(255) null,
    notification_emails text         null,
    deleted             datetime     null,
    updated_at          datetime     null,
    created_at          datetime     null
)
    charset = utf8;

create table unscripted_genres
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted    datetime     null,
    updated_at datetime     null,
    created_at datetime     null
)
    charset = utf8;

create table unscripted_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    created_at datetime     null,
    updated_at datetime     null,
    deleted_at datetime     null
)
    charset = utf8;

create table updates
(
    id              int(11) unsigned auto_increment
        primary key,
    name            varchar(255)     null,
    content         text             null,
    updates_type_id int(11) unsigned null,
    submitted_by    int(11) unsigned null,
    deleted_at      datetime         null,
    updated_at      datetime         not null,
    created_at      datetime         not null
)
    charset = utf8;

create table updates_files
(
    id         int(11) unsigned auto_increment
        primary key,
    updates_id int(11) unsigned not null,
    file_path  text             null,
    created_at datetime         null,
    updated_at datetime         null,
    deleted_at datetime         null
)
    charset = utf8;

create table updates_types
(
    id         int(11) unsigned auto_increment
        primary key,
    name       varchar(255) null,
    deleted_at datetime     null,
    updated_at datetime     not null,
    created_at datetime     not null
)
    charset = utf8;

create table users
(
    id                    int(11) unsigned auto_increment
        primary key,
    slug                  varchar(255)                            null,
    first_name            varchar(255)                            null,
    last_name             varchar(255)                            null,
    agencies_id           int                                     null,
    original_agency       text                                    null,
    user_id_old           int                                     null,
    agent_code            text                                    null,
    title                 text                                    null,
    reports_to_DO_NOT_USE int                                     null,
    office                text                                    null,
    email                 varchar(255)                            null,
    auth0_email           varchar(255)                            null,
    phone_ext             text                                    null,
    phone_direct          text                                    null,
    phone_mobile          text                                    null,
    audio_file            text                                    null,
    main_image            text                                    null,
    aim                   text                                    null,
    birthday              date                                    null,
    bio                   text                                    null,
    adp_file              int                                     null,
    agreed_to_nda         datetime                                null,
    inactive_date         datetime                                null,
    deleted_at            datetime                                null,
    updated_at            datetime                                null,
    created_at            datetime                                null,
    gcp_role              varchar(50) default 'agencyUser'        null,
    permissions           text                                    null,
    remember_token        varchar(100) collate utf8mb4_unicode_ci null
)
    charset = utf8;

create table users_departments
(
    id             int(11) unsigned auto_increment
        primary key,
    users_id       int(11) unsigned not null,
    departments_id int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table users_divisions
(
    id           int(11) unsigned auto_increment
        primary key,
    users_id     int(11) unsigned not null,
    divisions_id int(11) unsigned not null,
    deleted_at   datetime         null,
    updated_at   datetime         null,
    created_at   datetime         null
)
    charset = utf8;

create table users_leadership
(
    id            int(11) unsigned auto_increment
        primary key,
    users_id      int(11) unsigned not null,
    leadership_id int(11) unsigned not null,
    deleted       datetime         null,
    updated_at    datetime         null,
    created_at    datetime         null
)
    charset = utf8;

create table users_office_team
(
    id             int(11) unsigned auto_increment
        primary key,
    users_id       int(11) unsigned not null,
    office_team_id int(11) unsigned not null,
    deleted        datetime         null,
    updated_at     datetime         null,
    created_at     datetime         null
)
    charset = utf8;

create table users_reports_to_users
(
    id                  int(11) unsigned auto_increment
        primary key,
    users_id            int(11) unsigned not null,
    reports_to_users_id int(11) unsigned not null,
    `order`             int default 0    null,
    order_within_team   int default 0    null,
    created_at          datetime         null,
    updated_at          datetime         null,
    deleted_at          datetime         null
)
    charset = utf8;

create table users_roles
(
    id         int(11) unsigned auto_increment
        primary key,
    users_id   int(11) unsigned not null,
    roles_id   int(11) unsigned not null,
    deleted    datetime         null,
    updated_at datetime         null,
    created_at datetime         null
)
    charset = utf8;

create table users_teams
(
    id         int(11) unsigned auto_increment
        primary key,
    users_id   int(11) unsigned not null,
    teams_id   int(11) unsigned not null,
    deleted    datetime         null,
    updated_at datetime         null,
    created_at datetime         null
)
    charset = utf8;

create table users_tribes
(
    id         int(11) unsigned auto_increment
        primary key,
    users_id   int(11) unsigned not null,
    tribes_id  int(11) unsigned not null,
    deleted    datetime         null,
    updated_at datetime         null,
    created_at datetime         null
)
    charset = utf8;

