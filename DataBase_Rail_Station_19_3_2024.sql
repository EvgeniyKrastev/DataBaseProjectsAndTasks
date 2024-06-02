CREATE DATABASE Railway_Station
-- ne moje da raboti s kirilica 

drop database Railway_Station

drop table STATIONS
drop table TRACKS
drop table Schedules 
drop table TRAINS
drop table TRAIN_TRACK


CREATE TABLE STATIONS
(
	Station_ID INT NOT NULL PRIMARY KEY  IDENTITY(1, 1) ,
	Name NVARCHAR (200) NOT NULL
)

--000000000000000000000000000000000000000000000000000000000000000000000000000
CREATE TABLE TRACKS 
(
	Track_ID INT NOT NULL PRIMARY KEY  IDENTITY(1, 1),
	NAME NVARCHAR(500) NOT NULL,
	SourceStationID int not null,
	DestinationStationID int not null,
)

ALTER TABLE TRACKS 
ADD CONSTRAINT  FK_SOURCE_STATION 
FOREIGN KEY (SourceStationID) REFERENCES STATIONS (Station_ID)

ALTER TABLE TRACKS 
ADD CONSTRAINT  FK_DESTINATION_STATION 
FOREIGN KEY (DestinationStationID) REFERENCES STATIONS (Station_ID)

ALTER TABLE TRACKS 
ADD CONSTRAINT  CHECK_SOURCE_DESTINATION_DIFFERENT 
CHECK (SourceStationID != DestinationStationID )

--000000000000000000000000000000000000000000000000000000000000000000000000000

-- Schedules grafik, razpisanie
CREATE TABLE Schedules 
(
	Schedule_ID int not null primary key IDENTITY(1, 1) ,
	DepartureTime datetime not null,
	ArrivalTime datetime not null,
	TrackID int not null
)

ALTER TABLE Schedules 
ADD CONSTRAINT  FK_Schedules_Track
FOREIGN KEY (Track_ID) REFERENCES TRACKS (Track_ID)

--000000000000000000000000000000000000000000000000000000000000000000000000000

CREATE TABLE TRAINS 
(
	Train_Number nchar(10) not null primary key ,
	Description nvarchar(500) null,
)

--000000000000000000000000000000000000000000000000000000000000000000000000000

CREATE TABLE TRAIN_TRACK 
(
	TrainID nchar(10) not null primary key,
	TrackID int not null
)

ALTER TABLE TRAIN_TRACK 
ADD CONSTRAINT FK_TRAIN
FOREIGN KEY (TrainID) REFERENCES TRAINS (Train_Number)

ALTER TABLE TRAIN_TRACK
ADD CONSTRAINT FK_TRACK
FOREIGN KEY (TrackID) REFERENCES TRACKS (Track_ID)
--000000000000000000000000000000000000000000000000000000000000000000000000000-- 3 DOBAVQNE NA NQKOLKO ZAPISA VAV VSI4KI TABLICIINSERT INTO SchedulesVALUES ( CONVERT(DATETIME, '20-11-2020 10:30', 105), CONVERT(DATETIME, '20-11-2020 11:30', 105), 1)INSERT INTO SchedulesVALUES ( CONVERT(DATETIME, '13-07-2010 12:30', 105), CONVERT(DATETIME, '13-07-2010 13:30', 105), 2)INSERT INTO SchedulesVALUES ( CONVERT(DATETIME, '13-07-2010 14:30', 105), CONVERT(DATETIME, '13-07-2010 15:30', 105), 3)INSERT INTO StationsVALUES ('Plovdiv')INSERT INTO StationsVALUES ('Sofia')INSERT INTO StationsVALUES ('Burgas')select * from stationsINSERT INTO TracksVALUES ('Plovdiv-Burgas')INSERT INTO TRACKSVALUES ('Plovdiv-Sofia',1,2)INSERT INTO TRACKSVALUES ('Sofia-Burgas',2,3)INSERT INTO TRACKSVALUES ('Plovdiv-Burgas',1,3)INSERT INTO TRAINSVALUES ('V1','VLAK 1')INSERT INTO TRAINSVALUES ('V2','VLAK 2')INSERT INTO TRAINSVALUES ('V3','VLAK 3')INSERT INTO TRAIN_TRACKVALUES ('V1',1)INSERT INTO TRAIN_TRACKVALUES ('V2',2)INSERT INTO TRAIN_TRACKVALUES ('V3',3)-- 4 DA SE DOBAVI NOVA KOLONA Type(nvarchar(100),null) --sudurja informaciq za vlaka putni4eski express ili burz w tablica TRAINSalter table TRAINSADD Tip nvarchar(100) null-- 5 da se vuvedat stoinosti za tipupdate trains set Tip = 'express'where Train_Number = 'V1'update trains set Tip = 'fast'where Train_Number = 'V2'update trains set Tip = 'putni4eski'where Train_Number = 'V3'select * from trains-- 6 da se izvedat vsi4ki destinacii za 1 ot vlakoveteselect *from tracks trc, TRAIN_TRACK tt, TRAINS trnwhere trc.Track_ID = tt.TrackIDand  tt.TrainID = trn.Train_Numberand Train_Number = 'v2'-- 7 da se izvedat vsi4ki vazmojni  vlakove i razpisanie za destinaciq plovdiv sofiaselect *from tracks trcright join TRAIN_TRACK tt on trc.Track_ID = tt.TrackIDright join trains trn on  tt.TrainID = trn.Train_Numberunion select *from tracks trc, TRAIN_TRACK tt, TRAINS trnwhere trc.Track_ID = tt.TrackIDand  tt.TrainID = trn.Train_Numberand trc.name = 'Plovdiv-Sofia'-- 8 da se izvedat vsi4ki  vlakove i razpisanie za destinaciq plovdiv sofia 20.11.2020gselect Description, name, DepartureTimefrom tracks trc, TRAIN_TRACK tt, TRAINS trn, Schedules scwhere trc.Track_ID = tt.TrackIDand  tt.TrainID = trn.Train_Numberand sc.TrackID = trc.Track_IDand trc.name = 'Plovdiv-Sofia' and sc.DepartureTime = '2020-11-20 10:30:00.000' -- 9 da se suzdade izgled koito izvejda vsi4ki vlakove destinaciqta i razpisanieto na suovetniq vlakcreate view trains_tracksasselect trn.Description, trc.name, DepartureTimefrom tracks trc, TRAIN_TRACK tt, TRAINS trn, Schedules scwhere trc.Track_ID = tt.TrackIDand  tt.TrainID = trn.Train_Numberand sc.TrackID = trc.Track_IDselect * from trains_tracks