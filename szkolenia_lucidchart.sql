CREATE TABLE szkolenia_status (
  status_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (status_id)
);

CREATE OR REPLACE TRIGGER szkolenia_status_biu
    BEFORE INSERT OR UPDATE
    ON szkolenia_status
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END szkolenia_status_biu;
/

insert into szkolenia_status(nazwa) values ('Dostępne');
insert into szkolenia_status(nazwa) values ('Brak miejsc');
insert into szkolenia_status(nazwa) values ('Termin ustalany przez trenera');
insert into szkolenia_status(nazwa) values ('Szkolenie w opracowaniu');

CREATE TABLE szkolenia_kategorie (
  kategoria_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (kategoria_id)
);

CREATE OR REPLACE TRIGGER szkolenia_kategorie_biu
    BEFORE INSERT OR UPDATE
    ON szkolenia_kategorie
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END szkolenia_kategorie_biu;
/

insert into szkolenia_kategorie(nazwa) values('Standardowe');
insert into szkolenia_kategorie(nazwa) values('Mentoring');

CREATE TABLE szkolenia (
  szkolenie_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  kategoria_id integer,
  status_id integer,
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (szkolenie_id),
  CONSTRAINT FK_szkolenia_status_id
    FOREIGN KEY (status_id)
      REFERENCES szkolenia_status(status_id),
  CONSTRAINT FK_szkolenia_kategoria_id
    FOREIGN KEY (kategoria_id)
      REFERENCES szkolenia_kategorie(kategoria_id)
);

CREATE OR REPLACE TRIGGER szkolenia_biu
    BEFORE INSERT OR UPDATE
    ON szkolenia
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END szkolenia_biu;
/

insert into szkolenia(nazwa,kategoria_id,status_id) values('Szkolenie z PL/SQL',1,3);
insert into szkolenia(nazwa,kategoria_id,status_id) values('Administracja Bazami Danych',1,3);
insert into szkolenia(nazwa,kategoria_id,status_id) values('Optymalizacja zapytań SQL',1,3);

CREATE TABLE terminy_status (
  status_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (status_id)
);

CREATE OR REPLACE TRIGGER terminy_status_biu
    BEFORE INSERT OR UPDATE
    ON terminy_status
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END terminy_status_biu;
/

CREATE TABLE trenerzy (
  trener_id integer GENERATED BY DEFAULT AS IDENTITY,
  imie varchar2(255),
  nazwisko varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (trener_id)
);

CREATE OR REPLACE TRIGGER trenerzy_biu
    BEFORE INSERT OR UPDATE
    ON trenerzy
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END trenerzy_biu;
/

CREATE TABLE szkolenia_terminy (
  termin_id integer GENERATED BY DEFAULT AS IDENTITY,
  szkolenie_id integer,
  data_rozpoczecia date,
  data_zakonczenia date,
  min_ilosc_uczestnikow number,
  max_ilosc_uczestnikow number,
  trener_id integer,
  status_id integer,
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (termin_id),
  CONSTRAINT FK_szkolenia_terminy_szkolenie_id
    FOREIGN KEY (szkolenie_id)
      REFERENCES szkolenia(szkolenie_id),
  CONSTRAINT FK_szkolenia_terminy_status_id
    FOREIGN KEY (status_id)
      REFERENCES terminy_status(status_id),
  CONSTRAINT FK_szkolenia_terminy_trener_id
    FOREIGN KEY (trener_id)
      REFERENCES trenerzy(trener_id)
);

CREATE OR REPLACE TRIGGER szkolenia_terminy_biu
    BEFORE INSERT OR UPDATE
    ON szkolenia_terminy
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END szkolenia_terminy_biu;
/

CREATE TABLE slowa_kluczowe (
  slowo_kluczowe_id integer GENERATED BY DEFAULT AS IDENTITY,
  szkolenie_id integer,
  nazwa varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (slowo_kluczowe_id),
  CONSTRAINT FK_slowa_kluczowe_szkolenie_id
    FOREIGN KEY (szkolenie_id)
      REFERENCES szkolenia(szkolenie_id)
);

CREATE OR REPLACE TRIGGER slowa_kluczowe_biu
    BEFORE INSERT OR UPDATE
    ON slowa_kluczowe
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END slowa_kluczowe_biu;
/

CREATE TABLE uczestnicy_status (
  status_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (status_id)
);

INSERT INTO uczestnicy_status(nazwa) VALUES('Wysłano zaproszenie');
INSERT INTO uczestnicy_status(nazwa) VALUES('Zaakceptowane');

CREATE OR REPLACE TRIGGER uczestnicy_status_biu
    BEFORE INSERT OR UPDATE
    ON uczestnicy_status
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END uczestnicy_status_biu;
/

CREATE TABLE szkolenia_uczestnicy (
  uczestnik_id integer GENERATED BY DEFAULT AS IDENTITY,
  termin_id integer,
  imie varchar2(255),
  nazwisko varchar2(255),
  status_id integer,
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (uczestnik_id),
  CONSTRAINT FK_szkolenia_uczestnicy_status_id
    FOREIGN KEY (status_id)
      REFERENCES uczestnicy_status(status_id)
);

CREATE OR REPLACE TRIGGER szkolenia_uczestnicy_biu
    BEFORE INSERT OR UPDATE
    ON szkolenia_uczestnicy
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END szkolenia_uczestnicy_biu;
/

CREATE TABLE nagrody_kategorie (
  nagroda_id integer GENERATED BY DEFAULT AS IDENTITY,
  nazwa varchar2(255),
  ilosc_punktow number,
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (nagroda_id)
);

CREATE OR REPLACE TRIGGER nagrody_kategorie_biu
    BEFORE INSERT OR UPDATE
    ON nagrody_kategorie
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END nagrody_kategorie_biu;
/

CREATE TABLE trenerzy_nagrody (
  punkty_id integer GENERATED BY DEFAULT AS IDENTITY,
  trener_id integer,
  nagroda_id integer,
  wprowadzajacy varchar2(255),
  data_wprowadzenia date,
  modyfikujacy varchar2(255),
  data_modyfikacji date,
  PRIMARY KEY (punkty_id),
  CONSTRAINT FK_trenerzy_nagrody_trener_id
    FOREIGN KEY (trener_id)
      REFERENCES trenerzy(trener_id),
  CONSTRAINT FK_trenerzy_nagrody_nagroda_id
    FOREIGN KEY (nagroda_id)
      REFERENCES nagrody_kategorie(nagroda_id)
);

CREATE OR REPLACE TRIGGER trenerzy_nagrody_biu
    BEFORE INSERT OR UPDATE
    ON trenerzy_nagrody
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :new.data_wprowadzenia := SYSDATE;
        :new.wprowadzajacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
    END IF;
    :new.data_modyfikacji := SYSDATE;
    :new.modyfikujacy := COALESCE(SYS_CONTEXT('APEX$SESSION', 'APP_USER'), USER);
END trenerzy_nagrody_biu;
/


ALTER TABLE szkolenia
    ADD opis VARCHAR2(1000)
/

ALTER TABLE szkolenia_uczestnicy
    ADD username VARCHAR2(255)
/
