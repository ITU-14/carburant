/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  28/02/2017 15:27:42                      */
/*==============================================================*/


drop index CARBURANT_PK;

drop table CARBURANT CASCADE;

drop index LIEU_PK;

drop table LIEU CASCADE;

drop index CARBRAVITAILLEMENT_FK;

drop index RAVITAILLEMENT_FK;

drop index RAVITAILLEMENTSTATION_PK;

drop table RAVITAILLEMENTSTATION;

drop index SOCIETE_PK;

drop table SOCIETE CASCADE;

drop index ASSOCIATION_6_FK;

drop index LIEUSTATION_FK;

drop index STATION_PK;

drop table STATION CASCADE;

drop index UTILISATEUR_PK;

drop table UTILISATEUR;

drop index VENTESURSTATION_FK;

drop index VENTECARBURANT_FK;

drop index VENTE_PK;

drop table VENTE CASCADE;

/*==============================================================*/
/* Table : CARBURANT                                            */
/*==============================================================*/
create table CARBURANT (
   IDCARBURANT          SERIAL               not null,
   DESIGNATION          VARCHAR(50)          null,
   PRIXVENTE            NUMERIC(10,2)        null,
   constraint PK_CARBURANT primary key (IDCARBURANT)
);

/*==============================================================*/
/* Index : CARBURANT_PK                                         */
/*==============================================================*/
create unique index CARBURANT_PK on CARBURANT (
IDCARBURANT
);

/*==============================================================*/
/* Table : LIEU                                                 */
/*==============================================================*/
create table LIEU (
   IDLIEU               SERIAL               not null,
   NOMLIEU              VARCHAR(50)          null,
   constraint PK_LIEU primary key (IDLIEU)
);

/*==============================================================*/
/* Index : LIEU_PK                                              */
/*==============================================================*/
create unique index LIEU_PK on LIEU (
IDLIEU
);

/*==============================================================*/
/* Table : RAVITAILLEMENTSTATION                                */
/*==============================================================*/
create table RAVITAILLEMENTSTATION (
   IDRAV                SERIAL               not null,
   IDSTATION            INT4                 not null,
   IDCARBURANT          INT4                 not null,
   DATERAV              DATE                 null,
   QUANTITE             NUMERIC(8,2)         null,
   PRIXUNIT             NUMERIC(10,2)        null,
   constraint PK_RAVITAILLEMENTSTATION primary key (IDRAV)
);

/*==============================================================*/
/* Index : RAVITAILLEMENTSTATION_PK                             */
/*==============================================================*/
create unique index RAVITAILLEMENTSTATION_PK on RAVITAILLEMENTSTATION (
IDRAV
);

/*==============================================================*/
/* Index : RAVITAILLEMENT_FK                                    */
/*==============================================================*/
create  index RAVITAILLEMENT_FK on RAVITAILLEMENTSTATION (
IDSTATION
);

/*==============================================================*/
/* Index : CARBRAVITAILLEMENT_FK                                */
/*==============================================================*/
create  index CARBRAVITAILLEMENT_FK on RAVITAILLEMENTSTATION (
IDCARBURANT
);

/*==============================================================*/
/* Table : SOCIETE                                              */
/*==============================================================*/
create table SOCIETE (
   IDSOCIETE            SERIAL               not null,
   NOMSOCIETE           VARCHAR(30)          null,
   constraint PK_SOCIETE primary key (IDSOCIETE)
);

/*==============================================================*/
/* Index : SOCIETE_PK                                           */
/*==============================================================*/
create unique index SOCIETE_PK on SOCIETE (
IDSOCIETE
);

/*==============================================================*/
/* Table : STATION                                              */
/*==============================================================*/
create table STATION (
   IDSTATION            SERIAL               not null,
   IDLIEU               INT4                 not null,
   IDSOCIETE            INT4                 not null,
   NOMSTATION           VARCHAR(60)          null,
   CAPACITESP           NUMERIC(8,2)         null,
   CAPACITEGAS          NUMERIC(8,2)         null,
   CAPACITEESS          NUMERIC(8,2)         null,
   constraint PK_STATION primary key (IDSTATION)
);

/*==============================================================*/
/* Index : STATION_PK                                           */
/*==============================================================*/
create unique index STATION_PK on STATION (
IDSTATION
);

/*==============================================================*/
/* Index : LIEUSTATION_FK                                       */
/*==============================================================*/
create  index LIEUSTATION_FK on STATION (
IDLIEU
);

/*==============================================================*/
/* Index : ASSOCIATION_6_FK                                     */
/*==============================================================*/
create  index ASSOCIATION_6_FK on STATION (
IDSOCIETE
);

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR (
   IDUSER               SERIAL               not null,
   NOMUSER              VARCHAR(50)          null,
   PRENOMUSER           VARCHAR(50)          null,
   DATENAISSANCE		DATE				 UNIQUE NOT null,
   SEXEUSER             VARCHAR(5)           null,
   MAILUSER             VARCHAR(70)          null,
   MOTDEPASSE           VARCHAR(50)          null,
   constraint PK_UTILISATEUR primary key (IDUSER)
);

/*==============================================================*/
/* Index : UTILISATEUR_PK                                       */
/*==============================================================*/
create unique index UTILISATEUR_PK on UTILISATEUR (
IDUSER
);

/*==============================================================*/
/* Table : VENTE                                                */
/*==============================================================*/
create table VENTE (
   IDVENTE              SERIAL               not null,
   IDSTATION            INT4                 not null,
   IDCARBURANT          INT4                 not null,
   QUANTITESORTIE       NUMERIC(8,2)         null,
   DATEVENTE            DATE                 null,
   constraint PK_VENTE primary key (IDVENTE)
);

/*==============================================================*/
/* Index : VENTE_PK                                             */
/*==============================================================*/
create unique index VENTE_PK on VENTE (
IDVENTE
);

/*==============================================================*/
/* Index : VENTECARBURANT_FK                                    */
/*==============================================================*/
create  index VENTECARBURANT_FK on VENTE (
IDCARBURANT
);

/*==============================================================*/
/* Index : VENTESURSTATION_FK                                   */
/*==============================================================*/
create  index VENTESURSTATION_FK on VENTE (
IDSTATION
);

alter table RAVITAILLEMENTSTATION
   add constraint FK_RAVITAIL_CARBRAVIT_CARBURAN foreign key (IDCARBURANT)
      references CARBURANT (IDCARBURANT)
      on delete restrict on update restrict;

alter table RAVITAILLEMENTSTATION
   add constraint FK_RAVITAIL_RAVITAILL_STATION foreign key (IDSTATION)
      references STATION (IDSTATION)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_ASSOCIATI_SOCIETE foreign key (IDSOCIETE)
      references SOCIETE (IDSOCIETE)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_LIEUSTATI_LIEU foreign key (IDLIEU)
      references LIEU (IDLIEU)
      on delete restrict on update restrict;

alter table VENTE
   add constraint FK_VENTE_VENTECARB_CARBURAN foreign key (IDCARBURANT)
      references CARBURANT (IDCARBURANT)
      on delete restrict on update restrict;

alter table VENTE
   add constraint FK_VENTE_VENTESURS_STATION foreign key (IDSTATION)
      references STATION (IDSTATION)
      on delete restrict on update restrict;

