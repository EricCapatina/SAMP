#include <a_samp>
#include <fix>
#include <a_mysql>
#include <streamer>
#include <Pawn.CMD>
#include <sscanf2>
#include <Foreach>
#include <Pawn.Regex>
#include <crashdetect>

#define CGRAY 0xAFAFAFAA
#define CGREEN 0x33AA33AA
#define CRED 0xFF0000AA
#define CLIGHTRED 0xFF0033FF
#define CYELLOW 0xFFFF00AA
#define CWHITE 0xFFFFFFFF
#define CBLUE 0x4682B4AA
#define CLIGHTBLUE 0x33CCFFAA
#define CORANGE 0xFF9900AA
#define CSYSTEM 0xEFEFF7AA
#define CPINK 0xDD90FFFF
#define CBRIGHTRED 0xB2222200
#define CDARKGREEN 0x004400AA
#define CLIGHTGREEN 0x00FF00AA
#define CCON_GREEN 0x00FF00FF
#define CBROWN 0x8b4513FF
#define CINFO 0x269BD8FF
#define cINFO 269BD8
#define CBADINFO 0xFF182DFF
#define CADMIN 0xF36223FF
#define CDEPARTMENT 0x007FFFFF
#define CRADIO 0x6B8E23FF
#define CBRIGHTYELLOW 0xFFCC99FF
#define cGRAY AFAFAF
#define cGREEN 33AA33
#define cRED FF0000
#define cLIGHTRED FF0033
#define cBL 1D99D4
#define cRE F04245
#define cOR F3BB33
#define cGR 63BD4E
#define cY FFFF00
#define cYELLOW FFFF00
#define cLY ffff54
#define cBY FFCC99
#define cW FFFFFF
#define cWHITE FFFFFF
#define cV FFC801
#define cBLUE 4682B4
#define cLIGHTBLUE 33CCFF 
#define cORANGE FF9900
#define cSYSTEM EFEFF7
#define cPINK E75480
#define cBRIGHTRED B22222
#define cDARKGREEN 004400
#define cLIGHTGREEN 00FF00
#define cBROWN 8b4513
#define cINFO 269BD8
#define cBADINFO FF182D
#define cDEPARTMENT 007FFF
#define cRADIO 6B8E23
#define COLOR_MRED          0xF04245FF
#define COLOR_MGREEN        0x63BD4EFF
#define COLOR_MORANGE       0xfa5000FF
#define COLOR_MBLUE         0x037afaFF
#define COLOR_SEA 			0x00808000
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_LIGHTYELLOW 	0xFFFF00AA
#define COLOR_LIGHTRED 		0xFF5030AA
#define COLOR_LIGHTRED2 	0xFF0000FF
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN 	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_YELLOW2 		0xF5DEB3AA
#define COLOR_WHITE 		0xFFFFFFAA
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_TOMATO 		0xFF6347AA
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_BLUE 			0x33AAFFFF
#define COLOR_ENTER 		0x3333FFAA
#define COLOR_FADE5 		0x6E6E6E6E
#define COLOR_PURPLE		0xDD90FFAA
#define COLOR_LIME			0x66CC00AA
#define COLOR_DBLUE 		0x2641FEAA
#define COLOR_ALLDEPT 		0xFF8282AA
#define COLOR_NEWS 			0xFFA500AA
#define COLOR_OOC 			0xE0FFFFAA
#define COLOR_ORANGE 		0xFF9900AA
#define TEAM_BLUE_COLOR 	0x8D8DFF00
#define COLOR_BLACK 		0x000000AA
#define COLOR_BOX   		0x00000050
#define COLOR_BBLUE 		0x20A9FFAA
#define COLOR_BORDER 		0x00000AA
#define COLOR_INDIGO 		0x4B00B0AA
#define TEAM_GROVE_COLOR 	0x00D900C8
#define TEAM_VAGOS_COLOR 	0xFFC801C8
#define TEAM_BALLAS_COLOR 	0x6666FFC8
#define TEAM_AZTECAS_COLOR 	0x01FCFFC8
#define TEAM_SEVILLE_COLOR  0x00FF7FAA
#define COLOR_ISPOLZUY 0x7FB151FF
#define COLOR_SYSTEM 0xEFEFF7AA

#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASS ""
#define MYSQL_BASE "krab_project"

#define SCM 	SendClientMessage
#define SCMAll 	SendClientMessageToAll
#define SPD 	ShowPlayerDialog
#define SCMError(%0,%1) SCM(%0, RED_COLOR, %1), PlayerPlaySound(%0, 1085, 0.0, 0.0, 0.0)
#define SCMNotification(%0,%1) SCM(%0, WHITE_COLOR, %1), PlayerPlaySound(%0, 1083, 0.0, 0.0, 0.0)

#define WHITE_COLOR 0xFFFFFFFF
#define RED_COLOR 0xFF0000FF
#define GREEN_COLOR 0x11dd77FF

#define MAX_ADMINS 50
#pragma dynamic 6000


#define F_BALLAS 			2
#define F_GROVE  			1
#define F_AZTEC  			3
#define F_VAGOS  			5
#define F_RIFA   			4
#define F_SEVILLE           6
#define F_RHBALLAS          7
#define F_TDBALLAS          8
#define F_KTBALLAS          9
#define MAX_GZONE 			71
#define MAX_GANGS 			11
#define FRACTION_COUNT 		22
#define	AMMO_DEAGLE			35
#define AMMO_PISTOL         20
#define AMMO_SHOTGUN        5
#define AMMO_MP5            5

main()
{
	print("\n----------------------------------");
	print(" krab mode Activated");
	print("----------------------------------\n");
}


//============================
static pPickupID[MAX_PLAYERS];
new MySQL:dbHandle;
new AFK[MAX_PLAYERS];
new needexp = 12;
new Races[3][] = {"Negroid", "Europoid", "Mongoloid"};
new Iterator:Admins_ITER<MAX_ADMINS>;
new Iterator:Question_ITER<MAX_PLAYERS/2>;
new LoginTimer[MAX_PLAYERS];
new iPlayerAmmo[MAX_PLAYERS];
new iNewPlayerAmmo[MAX_PLAYERS];
new narcotimer;
new tagtimer;
//new hospitaltimer;
//new spraytag_timer;
new usedrugsbuff[MAX_PLAYERS];
new Hospitalized[MAX_PLAYERS];
//============================
new gFractionRankName[FRACTION_COUNT][11][18] =
{
	{"", "", "", "", "", "", "", "", "", "", ""},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
    {"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Young O.G", "Original Gangster"},
	{"", "", "", "", "", "", "", "", "", "Mafiazam", "MafiaLeader"},
	{"", "", "", "", "", "", "", "", "", "Mafiazam", "MafiaLeader"},
	{"", "", "", "", "", "", "", "", "", "Mafiazam", "MafiaLeader"},
	{"", "", "", "", "", "", "", "", "", "CopzamLS", "CopLeaderLS"},
	{"", "", "", "", "", "", "", "", "", "CopzamSF", "CopLeaderSF"},
	{"", "", "", "", "", "", "", "", "", "CopzamLV", "CopLeaderLV"},
	{"", "", "", "", "", "", "", "", "", "ArmyzamLS", "ArmyLeaderLS"},
	{"", "", "", "", "", "", "", "", "", "ArmyzamSF", "ArmyLeaderSF"},
	{"", "", "", "", "", "", "", "", "", "ArmyzamLV", "ArmyLeaderLV"},
	{"", "", "", "", "", "", "", "", "", "GovernZamLS", "GovernLeaderLS"},
	{"", "", "", "", "", "", "", "", "", "GovernZamSF", "GovernLeaderSF"},
	{"", "", "", "", "", "", "", "", "", "GovernZamLV", "GovernLeaderLV"}
};
new gFractionColor[FRACTION_COUNT] = {0xFFFFFF80, 0x3FDB3765, 0xEE15FF90, 0x1400FF85, 0x00EBFF65, 0xFFD80765, 0x00FF7F85, 0xFF007F85, 0xEE84FF90, 0x9F00FF55, 0xe6fb01AA, 0x000cff00, 0xff0000AA, 0x9eff4fAA, 0x6300f8AA};
new gFractionName[FRACTION_COUNT][33] = {"", "Grove Street Families", "Front Yard Ballas", "Varrio Los Aztecas", "San Fierro Rifa", "Los Santos Vagos", "Seville B.L.V.D Families", "Rollin Heights Ballas", "Temple Drive Ballas", "Kilo Tray Ballas", "Da Nang Boys", "Italian Mafia", "San Fierro Triads", "LSPD", "SFPD", "LVPD", "LS Army", "SF Army", "LV Army", "LS Government", "SF Government", "LV Government"};
////////////////////
new Text:speedbox;
new Text:speed1info[MAX_PLAYERS];
new timespeed[MAX_PLAYERS];
////////////////////
new bool:HoldingKey[MAX_PLAYERS];

////////////////////
enum GZINFO
{
 	idm,
 	//Float:gCoords[4],
 	Float:gCoords1,
 	Float:gCoords2,
 	Float:gCoords3,
 	Float:gCoords4,
 	gFrak,
 	gNapad,
 	gCreate
}
enum FRACCAR
{
	idc,
	FRACCARCOLOR1,
	FRACCARCOLOR2,
	Float:FRACCARPOSX,
	Float:FRACCARPOSY,
	Float:FRACCARPOSZ,
	Float:FRACCARANGLE,
	FRACCARFRACTION,
	FRACCARNUMBER,
	cCreate,
}
enum GANGTAG
{
	gtid,
	gtmodel,
	//Float:gtCoords[6],
	Float:gtCoords1,
	Float:gtCoords2,
	Float:gtCoords3,
	Float:gtCoords4,
	Float:gtCoords5,
	Float:gtCoords6,
	gfraction,
	gtCreate,
}
enum fracstore
{
	FRACID,
	FRACMONEY,
	FRACDRUGS,
	FRACAMMO,
}
const MAX_GANGZONE = 71;
new GZMZ[MAX_GANGZONE][GZINFO];
const MAXGANGTAGS = 21;
new gangtags_info[MAXGANGTAGS][GANGTAG];
const gangstore = 9;
new fracstorage[gangstore][fracstore];
new ZoneOnBattle[MAX_GZONE];
new TotalGz[9];
enum Ganginfa
{
	capture,
	score,
	captureid,
	gangnumber
}
new gangstartid = -1;
new GangInfo[MAX_GANGS][Ganginfa];
new IsCapture;
new bool:is_capture;
new captureID;
new GZSafeTime[MAX_GZONE];
new FrakCD;
new zGangTime[10];
new
	Text:CaptTime,
	Text:BandaCapt1a,
	Text:BandaCapt2a,
	Text:ScoreCapt1a,
	Text:ScoreCapt2a,
	Text:Textdraw4,
	Text:ScoreCapt;
new allowedfactions[] = { 1, 2, 3, 4, 5, 6, 7, 8};
new OnZONE[MAX_GZONE][50];
new gCurHour, gCurMinutes; //gCurDay;

////////////////////
//-------------- Pickups -------------
new fraccarbuy;
new infonoobs;
new TDBallaspickup[2];
new FYBallaspickup[2];
new GSFpickup[2];
new LSVpickup[2];
new KTBallaspickup[2];
new emmetpickupenter;
new emmetpickupexit;
new blackmarketgunpickup;
///////////NPC
//new ActorEmmet;
//---------------------------
new inadmcar[MAX_PLAYERS] = false;
// --------------------------------

enum player
{
	ID,
	NAME[MAX_PLAYER_NAME],
	PASSWORD[65],
	SOLI[11],
	EMAIL[64],
	SEX,
	RACE,
	AGE,
	SKIN,
	REGDATA[13],
	REGIP[16],
	ADMIN,
	MONEY,
	VOZRAST,
	VOZRASTEXP,
	MINUTES,
	QUESTION[98],
	HEROIN,
	FRACTION,
	LFRACTION,
	FRACTIONRANG,
	GUNSKILL[3],
	SKILLS[80],
	SHOWSKILLAC,
	SHOWSKILLPL,
	WEAPONID[13],
    AMMOS[13],
}

enum dialogs
{
	DLG_NONE,
	DLG_REG,
	DLG_REGEMAIL,
	DLG_REGSEX,
	DLG_REGRACE,
	DLG_REGAGE,
	DLG_LOG,
	DLG_STATS,
	DLG_REPORT,
	DLG_VOPROS,
	DLG_JALOBA,
	DLG_ANSWERPLAYER,
	DLG_ADDFASTANSWER,
	DLG_CAPTURE,
	DLG_MES,
	DLG_FRACCARCHOOSE,
	DLG_FRACCARID,
	DLG_NOOBS,
	DLG_GPSNOOBS,
	DLG_GANGNOOBINFO,
	DLG_GANGTAG,
	DLG_BLACKMARKETGUN,
	DLG_BLACKMARKETMES,
	DLG_BLACKMARKETGUNSELL,
	DLG_BLACKMARKETGUNSELLP,
	DLG_BLACKMARKETGUNSELLT,
	DLG_BLACKMARKETGUNSELLM,
	DLG_GGPS,
}

//////////////////////////////GZ//////////////////
//---------------------------------
//new creepscar[2];

//---------------------------------
const MAXFRACCAR = 21;
new player_info[MAX_PLAYERS][player];
new fraccar_info[MAX_VEHICLES][FRACCAR];
//new frac_info[fraction];

//---------------------------------

public OnGameModeInit()
{
	ConnectMySQL();
	SetTimer("SecondUpdate", 1000, true);
	SetTimer("MinuteUpdate", 60000, true);
	mysql_tquery(dbHandle, !"SELECT * FROM `gangzone`", "LoadGZ");
	mysql_tquery(dbHandle, !"SELECT * FROM `fraccar`", "LoadFRACCAR");
	mysql_tquery(dbHandle, !"SELECT * FROM `gangtags`", "LoadGTags");
	mysql_tquery(dbHandle, !"SELECT * FROM `fracstore`", "LoadFracStore");
	
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	LimitPlayerMarkerRadius(12.0);
	LimitGlobalChatRadius(13.0);
	Iter_Clear(Admins_ITER);
	Iter_Clear(Question_ITER);

///////////////////NPC
	CreateActor(6, 452.3184, 515.5523, 1001.4195, 140.2582);
////////////////////////MAP ICONS///////////////////////
	CreateDynamicMapIcon(2511.4995, -1470.1611, 24.0220, 23, 0, 0, 0, -1, 100.0);// Fraccar Black Market Icon
	CreateDynamicMapIcon(451.2149, 514.2817, 1001.4195, 23, 0, 0, 0, -1, 100.0);// Gun Black Market Icon
	CreateDynamicMapIcon(2495.3328, -1686.9163, 13.5149, 62, 0, 0, 0, -1, 200.0);// Grove Street Gang Icon
	CreateDynamicMapIcon(2467.0559, -1287.9199, 29.5738, 59, 0, 0, 0, -1, 200.0);// Front Yard Ballas Gang Icon
	CreateDynamicMapIcon(1857.7534, -2031.4261, 13.5469, 58, 0, 0, 0, -1, 200.0);// Varrio Los Aztecas Gang Icon
	CreateDynamicMapIcon(-2613.2830, -134.6033, 4.3359, 61, 0, 0, 0, -1, 200.0);// San Fierro Rifa Gang Icon
	CreateDynamicMapIcon(2745.9951, -1205.5792, 67.2822, 60, 0, 0, 0, -1, 200.0);// Los Santos Vagos Gang Icon
	CreateDynamicMapIcon(2784.1963, -1926.2349, 13.5469, 62, 0, 0, 0, -1, 200.0);// Seville B.L.V.D Gang Icon
	CreateDynamicMapIcon(893.8895, -1643.4985, 13.5469, 59, 0, 0, 0, -1, 200.0);// Rollin Heightz Ballas Icon
	CreateDynamicMapIcon(1149.4561, -1078.7603, 27.8569, 59, 0, 0, 0, -1, 200.0);// Temple Drive Ballas Gang Icon
	CreateDynamicMapIcon(1999.9841, -1120.4426, 26.7813, 59, 0, 0, 0, -1, 200.0);// Kilo Tray Ballas Gang Icon
////////////////////////////////////////////////////////

	Create3DTextLabel("{"#cBL"}Fraction {FFFFFF}Information / GPS", 0xFFFFFFF, 1243.1818, -1700.7148, 14.8672, 20.0, 0, 1);
////////////////////////////////////////////////////////
//////////////////////////temporary objects
////////////////////////////Kito Tray interior
	CreateObject(1525,227.3000000,1287.8000000,1083.1000000,0.0000000,0.0000000,0.0000000); //object(tag_kilo) (1) 1525
	CreateObject(1584,2331.5000000,-1061.4000000,1048.0000000,0.0000000,0.0000000,0.0000000); //object(tar_gun1) (1)
	CreateObject(372,2329.7000000,-1064.2000000,1048.6000000,270.0000000,266.2630000,302.2630000); //object(1)
	CreateObject(346,2336.1001000,-1069.3000000,1050.0000000,0.0000000,0.0000000,0.0000000); //object(2)
	CreateObject(346,2337.3999000,-1069.3000000,1050.0000000,0.0000000,0.0000000,0.0000000); //object(3)
	CreateObject(346,2336.7000000,-1069.3000000,1050.0000000,0.0000000,0.0000000,0.0000000); //object(4)
	CreateObject(352,2337.3999000,-1069.3000000,1051.1000000,0.0000000,0.0000000,0.0000000); //object(5)
	CreateObject(352,2336.1001000,-1069.3000000,1051.1000000,0.0000000,0.0000000,0.0000000); //object(6)
	CreateObject(1580,2338.7000000,-1068.1000000,1049.7000000,0.0000000,0.0000000,90.0000000); //object(drug_red) (1)
	CreateObject(1580,2338.7000000,-1067.2000000,1050.7000000,0.0000000,0.0000000,90.0000000); //object(drug_red) (2)
	CreateObject(2396,2338.3999000,-1069.1000000,1050.1000000,0.0000000,0.0000000,0.0000000); //object(cj_4_s_sweater) (1)
	CreateObject(2844,2337.0000000,-1066.7000000,1048.0000000,0.0000000,0.0000000,0.0000000); //object(gb_bedclothes03) (1)
	CreateObject(2846,2332.3000000,-1066.4000000,1048.0000000,0.0000000,0.0000000,0.0000000); //object(gb_bedclothes05) (1)
	CreateObject(1529,2341.8999000,-1061.3000000,1050.3000000,0.0000000,0.0000000,90.0000000); //object(tag_temple) (1)
	CreateObject(14840,2329.1001000,-1068.0000000,1049.9000000,0.0000000,0.0000000,0.0000000); //object(bdups_graf) (1)
	CreateObject(3052,2335.8999000,-1070.3000000,1048.1000000,0.0000000,0.0000000,0.0000000); //object(db_ammo) (1)
	CreateObject(3052,2336.8999000,-1070.3000000,1048.1000000,0.0000000,0.0000000,0.0000000); //object(db_ammo) (2)
	CreateObject(3052,2335.8999000,-1070.4000000,1048.5000000,0.0000000,28.0000000,12.0000000); //object(db_ammo) (3)
	CreateObject(2043,2336.3999000,-1070.3000000,1048.1000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_m4) (1)
	CreateObject(2359,2337.7000000,-1070.6000000,1048.2000000,0.0000000,0.0000000,270.0000000); //object(ammo_box_c5) (1)
	CreateObject(2037,2336.7000000,-1070.3000000,1048.3000000,0.0000000,0.0000000,0.0000000); //object(cj_pistol_ammo) (2)
	CreateObject(2045,2337.3000000,-1070.5000000,1048.1000000,0.0000000,0.0000000,0.0000000); //object(cj_bbat_nails) (1)
	CreateObject(2842,2336.3000000,-1072.6000000,1048.0000000,0.0000000,0.0000000,0.0000000); //object(gb_bedrug04) (1)
	CreateObject(2850,2335.6001000,-1068.7000000,1048.9000000,0.0000000,0.0000000,0.0000000); //object(gb_kitchdirt04) (1)
	CreateObject(2587,2336.8999000,-1061.9000000,1050.1000000,0.0000000,0.0000000,0.0000000); //object(sex_2) (1)
	CreateObject(17969,2517.7800000,-1747.4000000,14.5000000,0.0000000,0.0000000,180.0000000); //object(hub_graffitti) (1)
	CreateObject(4227,2185.8999000,-1148.0000000,27.6000000,0.0000000,0.0000000,270.0000000); //object(graffiti_lan01) (1)
	////////////////////////emmet black market exterior
	CreateObject(2934,2450.3000000,-1970.6000000,13.9000000,0.0000000,0.0000000,324.0000000); //object(kmb_container_red) (1)
	CreateObject(18260,2441.6001000,-1980.2000000,13.8000000,0.0000000,0.0000000,270.0000000); //object(crates01) (1)
	CreateObject(3015,2442.3999000,-1965.5000000,12.5000000,0.0000000,0.0000000,324.0000000); //object(cr_cratestack) (1)
	CreateObject(3015,2443.8000000,-1970.2000000,13.7000000,0.0000000,0.0000000,323.9980000); //object(cr_cratestack) (2)
	CreateObject(3015,2444.3000000,-1969.8000000,13.7000000,0.0000000,0.0000000,323.9980000); //object(cr_cratestack) (3)
	CreateObject(3066,2440.8000000,-1971.0000000,13.6000000,0.0000000,0.0000000,0.0000000); //object(ammotrn_obj) (1)
	CreateObject(2973,2441.1001000,-1964.1000000,12.5000000,0.0000000,0.0000000,0.0000000); //object(k_cargo2) (1)
	CreateObject(2973,2453.2000000,-1966.7000000,12.6000000,0.0000000,0.0000000,322.0000000); //object(k_cargo2) (2)
	CreateObject(1584,2446.6001000,-1962.3000000,15.2000000,0.0000000,0.0000000,0.0000000); //object(tar_gun1) (1)
	CreateObject(1585,2449.1001000,-1962.3000000,15.2000000,0.0000000,0.0000000,0.0000000); //object(tar_civ2) (1)
	CreateObject(1223,2447.8000000,-1962.0000000,11.6000000,0.0000000,0.0000000,278.0000000); //object(lampost_coast) (1)
	CreateObject(14840,2439.8000000,-1980.6000000,15.4000000,0.0000000,0.0000000,0.0000000); //object(bdups_graf) (1)
	CreateObject(17969,2459.4890000,-1974.7000000,14.1000000,0.0000000,0.0000000,0.0000000); //object(hub_graffitti) (1)
	CreateObject(346,2444.3000000,-1970.7000000,13.7700000,274.0000000,0.0000000,0.0000000); //object(1)
	CreateObject(352,2443.6001000,-1970.7000000,13.7200000,90.0000000,180.0000000,180.0000000); //object(2)
	////////////////////////emmet black market interior
	CreateObject(974,453.1000100,508.2999900,1003.2000000,0.0000000,0.0000000,90.0000000); //object(tall_fence) (1)
	CreateObject(974,456.3999900,511.5000000,1003.2000000,0.0000000,0.0000000,0.0000000); //object(tall_fence) (3)
	CreateObject(974,453.2000100,517.5000000,1003.2000000,0.0000000,0.0000000,90.0000000); //object(tall_fence) (4)
	CreateObject(1529,452.7999900,507.2999900,1002.1000000,0.0000000,0.0000000,0.0000000); //object(tag_temple) (1)
	CreateObject(1685,453.2000100,507.2999900,1001.2000000,0.0000000,0.0000000,0.0000000); //object(blockpallet) (1)
	CreateObject(2039,452.6000100,512.0999800,1001.7000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_s1) (1)
	CreateObject(2040,452.6000100,511.7999900,1001.7000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_m1) (1)
	CreateObject(2041,452.6000100,511.3999900,1001.8000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_m2) (1)
	CreateObject(2042,452.7000100,510.8999900,1001.7000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_m3) (1)
	CreateObject(2359,451.6000100,516.0999800,1000.6000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_c5) (1)
	CreateObject(2359,450.6000100,516.0999800,1000.6000000,0.0000000,0.0000000,0.0000000); //object(ammo_box_c5) (2)
	CreateObject(1231,451.5000000,516.4000200,999.7999900,0.0000000,0.0000000,268.0000000); //object(streetlamp2) (1)
	CreateObject(1231,443.7000100,516.5000000,999.7999900,0.0000000,0.0000000,267.9950000); //object(streetlamp2) (2)
	CreateObject(356,452.7999900,511.3999900,1002.3000000,0.0000000,0.0000000,95.0000000); //object(1)
	CreateObject(3015,443.1000100,516.0000000,1000.6000000,0.0000000,0.0000000,0.0000000); //object(cr_cratestack) (1)
	CreateObject(3013,443.6000100,516.0000000,1000.5920000,0.0000000,0.0000000,0.0000000); //object(cr_ammobox) (1)
	CreateObject(3013,443.7000100,516.0000000,1000.8000000,0.0000000,0.0000000,0.0000000); //object(cr_ammobox) (2)
	CreateObject(3013,444.2000100,516.0000000,1000.6000000,0.0000000,0.0000000,0.0000000); //object(cr_ammobox) (3)
	CreateObject(2991,448.0000000,515.2999900,1001.0000000,0.0000000,0.0000000,0.0000000); //object(imy_bbox) (1)
	CreateObject(2975,447.2000100,515.7999900,1001.6000000,0.0000000,0.0000000,0.0000000); //object(k_cargo3) (1)
	CreateObject(964,449.0000000,515.2000100,1001.6000000,0.0000000,0.0000000,0.0000000); //object(cj_metal_crate) (2)
	CreateObject(14840,442.8999900,507.7000100,1002.3000000,0.0000000,0.0000000,358.5000000); //object(bdups_graf) (1)
	CreateObject(974,450.2000100,509.7000100,1003.8000000,90.0000000,0.0000000,90.0000000); //object(tall_fence) (2)
	CreateObject(974,444.7000100,509.7000100,1003.8000000,90.0000000,0.0000000,90.0000000); //object(tall_fence) (5)
	CreateObject(974,444.7000100,516.4000200,1003.8000000,90.0000000,0.0000000,90.0000000); //object(tall_fence) (6)
	CreateObject(974,450.2000100,516.4000200,1003.8000000,90.0000000,0.0000000,90.0000000); //object(tall_fence) (7)
	CreateObject(3577,454.8999900,513.5000000,1001.2000000,0.0000000,0.0000000,0.0000000); //object(dockcrates1_la) (1)
	CreateObject(1279,453.7999900,513.7000100,1002.0000000,0.0000000,0.0000000,80.0000000); //object(craigpackage) (1)
	CreateObject(1279,453.6000100,512.7000100,1002.0000000,0.0000000,0.0000000,79.9970000); //object(craigpackage) (2)
	CreateObject(1528,452.7999900,507.3999900,1004.2000000,0.0000000,0.0000000,0.0000000); //object(tag_seville) (1)
	CreateObject(1528,444.2999900,506.2999900,1002.3000000,0.0000000,0.0000000,270.0000000); //object(tag_seville) (2)
	
	//==================================
///////////////////////////////////////////
	
//	LoadMapping();
	LoadPickups();
/*	GroveStreet ---- AddStaticVehicleEx(402,2473.3000000,-1694.2000000,13.5000000,0.0000000,70,89,15); //Buffalo

*/


    ScoreCapt = TextDrawCreate(14.000000, 260.000000, "Time:");
	TextDrawBackgroundColor(ScoreCapt, 255);
	TextDrawFont(ScoreCapt, 1);
	TextDrawLetterSize(ScoreCapt, 0.500000, 1.000000);
	TextDrawColor(ScoreCapt, TEAM_GROVE_COLOR);
	TextDrawSetOutline(ScoreCapt, 1);
	TextDrawSetProportional(ScoreCapt, 1);

	CaptTime = TextDrawCreate(75.000000, 260.000000, "1:00");
	TextDrawFont(CaptTime, 1);
	TextDrawLetterSize(CaptTime, 0.500000, 1.000000);
	TextDrawColor(CaptTime, TEAM_GROVE_COLOR);
	TextDrawSetOutline(CaptTime, 1);
	TextDrawSetProportional(CaptTime, 1);

	BandaCapt1a = TextDrawCreate(14.000000, 276.000000, "_");
	TextDrawFont(BandaCapt1a, 1);
	TextDrawLetterSize(BandaCapt1a, 0.500000, 1.000000);
	TextDrawColor(BandaCapt1a, -1);
	TextDrawSetOutline(BandaCapt1a, 1);
	TextDrawSetProportional(BandaCapt1a, 1);

	BandaCapt2a = TextDrawCreate(14.000000, 293.000000, "_");
	TextDrawFont(BandaCapt2a, 1);
	TextDrawLetterSize(BandaCapt2a, 0.500000, 1.000000);
	TextDrawColor(BandaCapt2a, -1);
	TextDrawSetOutline(BandaCapt2a, 1);
	TextDrawSetProportional(BandaCapt2a, 1);


	ScoreCapt1a = TextDrawCreate(190.000000, 277.000000, "0");
	TextDrawFont(ScoreCapt1a, 1);
	TextDrawLetterSize(ScoreCapt1a, 0.500000, 1.000000);
	TextDrawColor(ScoreCapt1a, COLOR_LIGHTRED2);
	TextDrawSetOutline(ScoreCapt1a, 1);
	TextDrawSetProportional(ScoreCapt1a, 1);

	Textdraw4 = TextDrawCreate(211.000000, 310.000000, "_");
	TextDrawUseBox(Textdraw4, 1);
	TextDrawTextSize(Textdraw4, 5.000000, 200.000000);
	TextDrawLetterSize(Textdraw4, 0.240000, -7.000000);
	TextDrawBoxColor(Textdraw4, COLOR_BOX);

	ScoreCapt2a = TextDrawCreate(190.000000, 293.000000, "0");
	TextDrawFont(ScoreCapt2a, 1);
	TextDrawLetterSize(ScoreCapt2a, 0.500000, 1.000000);
	TextDrawColor(ScoreCapt2a, COLOR_LIGHTRED2);
	TextDrawSetOutline(ScoreCapt2a, 1);
	TextDrawSetProportional(ScoreCapt2a, 1);
	
	for(new i; i < 10; i++) zGangTime[i] = 2;
	
	SetTimer("@__sec_timer", 1000, 1);
	///////////////
//	gCurDay = GetDayNumber();
	new h;
	gettime(h, gCurMinutes, gCurHour);
	SetWorldTime(h);
	new x;
	for(new cars; cars < MAXFRACCAR; cars++)
	{
    	x = cars + 1;
        if(!IsVehicleOccupied(x)) SetVehicleToRespawn(x);
        if(x == MAXFRACCAR)
		{
		return printf("All fraction cars respawned");
		}
	}
	
	return 1;
}
stock LoadRemovedObjects(playerid)
{
	#include <Maps/removedobjects.inc>
}
stock LoadPickups()
{
	fraccarbuy = CreateDynamicPickup(19605, 14, 2511.4995, -1470.1611, 24.0220, 0);
	infonoobs =  CreateDynamicPickup(1239, 23, 1243.1818, -1700.7148, 14.8672, 0);
	TDBallaspickup[0] = CreateDynamicPickup(19135, 23, 2333.0767, -1077.1313, 1049.0234, 0); //exit
	TDBallaspickup[1] = CreateDynamicPickup(19135, 23, 1136.0146, -1077.4625, 29.3812, 0); //enter
	FYBallaspickup[0] = CreateDynamicPickup(19135, 23, -42.6045, 1405.5258, 1084.4297, 0);//exit
	FYBallaspickup[1] = CreateDynamicPickup(19135, 23, 2470.3726, -1295.5085, 30.2332, 0);//enter
	GSFpickup[0] = CreateDynamicPickup(19135, 23, 2468.7227, -1698.2219, 1013.5078, 1);//exit
	GSFpickup[1] = CreateDynamicPickup(19135, 23, 2459.4944, -1691.6638, 13.5452, 0);//enter
	LSVpickup[0] = CreateDynamicPickup(19135, 23, 2365.2444, -1135.5985, 1050.8826, 0);//exit
	LSVpickup[1] = CreateDynamicPickup(19135, 23, 2756.3777, -1182.8085, 69.4035, 0);//enter
	KTBallaspickup[0] = CreateDynamicPickup(19135, 23, 223.1476, 1287.0760, 1082.1406, 0);//exit
	KTBallaspickup[1] = CreateDynamicPickup(19135, 23, 2000.0842, -1114.0535, 27.1250, 0);//enter
	emmetpickupenter = CreateDynamicPickup(19135, 23, 2447.8010, -1963.0006, 13.5469, 0);//enter
	emmetpickupexit = CreateDynamicPickup(19135, 23, 443.0272, 509.2844, 1001.4195, 0);//exit
	blackmarketgunpickup = CreateDynamicPickup(1314, 23, 451.2149, 514.2817, 1001.4195, 0);
	//mineexit = CreatePickup(1318, 23, X, Y, Z, virtualworld(1), interior(1));
}
/*stock LoadMapping()
{
	new tmpobjid; // замена текстур
	#include <Maps/mappingint.inc>
}*/
stock ConnectMySQL()
{
	dbHandle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_BASE);
	switch(mysql_errno())
	{
	    case 0: print("MySQL Connected!");
	    default: print("MySQL Not Connected!");
	}
 	mysql_log(ERROR | WARNING);
 	mysql_set_charset("cp1251");
}

public OnGameModeExit()
{
	KillTimer(narcotimer);
	KillTimer(tagtimer);
	//SaveWeapons();
	//KillTimer(hospitaltimer);
	return 1;
}

forward MinuteUpdate();
public MinuteUpdate()
{
	foreach(new i:Player)
	{
	    if(AFK[i] < 2)
	    {
	        player_info[i][MINUTES]++;
	        if(player_info[i][MINUTES] >= 60)
	        {
	            player_info[i][MINUTES] = 0;
             	PayDay(i);
	        }
	    }
	}
}

stock PayDay(playerid)
{
	SCM(playerid, WHITE_COLOR, "PayDay");
	GiveExp(playerid, 1);
}
stock FracPayDay()
{
	new tagsGSF, tagsFYB, tagsAztec, tagsRifa, tagsLSV, tagsSeville, tagsRHB, tagsTDB, tagsKTB;
	new gangzonesGSF, gangzonesFYB, gangzonesAztec, gangzonesRifa, gangzonesLSV, gangzonesSeville, gangzonesRHB, gangzonesTDB, gangzonesKTB;
    for (new stores; stores < gangstore; stores++)
	{
        for (new gt; gt < MAXGANGTAGS; gt++)
		{
			//if(gangtags_info[gt][gfraction] == fracstorage[stores][FRACID]) tags++;
			switch(gangtags_info[gt][gfraction])
		    {
		        case 1: if(fracstorage[stores][FRACID] == 1) tagsGSF++;
		        case 2: if(fracstorage[stores][FRACID] == 2) tagsFYB++;
		        case 3: if(fracstorage[stores][FRACID] == 3) tagsAztec++;
		        case 4: if(fracstorage[stores][FRACID] == 4) tagsRifa++;
		        case 5: if(fracstorage[stores][FRACID] == 5) tagsLSV++;
		        case 6: if(fracstorage[stores][FRACID] == 6) tagsSeville++;
		        case 7: if(fracstorage[stores][FRACID] == 7) tagsRHB++;
		        case 8: if(fracstorage[stores][FRACID] == 8) tagsTDB++;
		        case 9: if(fracstorage[stores][FRACID] == 9) tagsKTB++;
		    }
	 	}
        for (new gz; gz < MAX_GANGZONE; gz++)
		{
		    switch(GZMZ[gz][gFrak])
		    {
		        case 1: if(fracstorage[stores][FRACID] == 1) gangzonesGSF++;
		        case 2: if(fracstorage[stores][FRACID] == 2) gangzonesFYB++;
		        case 3: if(fracstorage[stores][FRACID] == 3) gangzonesAztec++;
		        case 4: if(fracstorage[stores][FRACID] == 4) gangzonesRifa++;
		        case 5: if(fracstorage[stores][FRACID] == 5) gangzonesLSV++;
		        case 6: if(fracstorage[stores][FRACID] == 6) gangzonesSeville++;
		        case 7: if(fracstorage[stores][FRACID] == 7) gangzonesRHB++;
		        case 8: if(fracstorage[stores][FRACID] == 8) gangzonesTDB++;
		        case 9: if(fracstorage[stores][FRACID] == 9) gangzonesKTB++;
		    }
		}
		new moneyGSF, moneyFYB, moneyAztec, moneyRifa, moneyLSV, moneySeville, moneyRHB, moneyTDB, moneyKTB;
		switch(fracstorage[stores][FRACID])
		{
		    case 1: moneyGSF = tagsGSF*70 + gangzonesGSF*105;
		    case 2: moneyFYB = tagsFYB*70 + gangzonesFYB*105;
		    case 3: moneyAztec = tagsAztec*70 + gangzonesAztec*105;
		    case 4: moneyRifa = tagsRifa*70 + gangzonesRifa*105;
		    case 5: moneyLSV = tagsLSV*70 + gangzonesLSV*105;
		    case 6: moneySeville = tagsSeville*70 + gangzonesSeville*105;
		    case 7: moneyRHB = tagsRHB*70 + gangzonesRHB*105;
		    case 8: moneyTDB = tagsTDB*70 + gangzonesTDB*105;
		    case 9: moneyKTB = tagsKTB*70 + gangzonesKTB*105;
		}
		foreach(new i: Player)
		{
			if(player_info[i][FRACTION] == fracstorage[stores][FRACID])
			{
			    new string[85], ftext[155];
			    ftext = "Your fraction got +%d$, Total: %d$\n From tags: %d$ From Gangzones: %d$";
			    switch(player_info[i][FRACTION])
				{
				    case 1: fracstorage[stores][FRACMONEY] += moneyGSF, format(string, sizeof(string), ftext,moneyGSF, fracstorage[stores][FRACMONEY], tagsGSF*70, gangzonesGSF*105);
				    case 2: fracstorage[stores][FRACMONEY] += moneyFYB, format(string, sizeof(string), ftext,moneyFYB, fracstorage[stores][FRACMONEY], tagsFYB*70, gangzonesFYB*105);
				    case 3: fracstorage[stores][FRACMONEY] += moneyAztec, format(string, sizeof(string), ftext,moneyAztec, fracstorage[stores][FRACMONEY], tagsAztec*70, gangzonesAztec*105);
				    case 4: fracstorage[stores][FRACMONEY] += moneyRifa, format(string, sizeof(string), ftext,moneyRifa, fracstorage[stores][FRACMONEY], tagsRifa*70, gangzonesRifa*105);
				    case 5: fracstorage[stores][FRACMONEY] += moneyLSV, format(string, sizeof(string), ftext,moneyLSV, fracstorage[stores][FRACMONEY], tagsLSV*70, gangzonesLSV*105);
				    case 6: fracstorage[stores][FRACMONEY] += moneySeville, format(string, sizeof(string), ftext,moneySeville, fracstorage[stores][FRACMONEY], tagsSeville*70, gangzonesSeville*105);
				    case 7: fracstorage[stores][FRACMONEY] += moneyRHB, format(string, sizeof(string), ftext,moneyRHB, fracstorage[stores][FRACMONEY], tagsRHB*70, gangzonesRHB*105);
				    case 8: fracstorage[stores][FRACMONEY] += moneyTDB, format(string, sizeof(string), ftext,moneyTDB, fracstorage[stores][FRACMONEY], tagsTDB*70, gangzonesTDB*105);
				    case 9: fracstorage[stores][FRACMONEY] += moneyKTB, format(string, sizeof(string), ftext,moneyKTB, fracstorage[stores][FRACMONEY], tagsKTB*70, gangzonesKTB*105);
				}
			    SCM(i, COLOR_LIGHTBLUE, string);
			}
		}
	    save_fracstores(stores);
	}
	SendClientMessageToAll(COLOR_LIGHTBLUE, "-== Fraction PayDay ==-");
}
forward SecondUpdate();
public SecondUpdate()
{
    new string[128];
	foreach(new i:Player)
	{
		if(AFK[i] == 0) AFK[i] = -1;
		else if(AFK[i] == -1)
		{
		    AFK[i] = 1;
		}
		else if(AFK[i] > 0)
		{
			AFK[i]++;
			if(AFK[i] > 1)
			{
				format(string, sizeof(string), "{FF0000}AFK: ");
				if(AFK[i] < 60) format(string, sizeof(string), "%s%d", string, AFK[i]);
				else if(AFK[i] >= 60 && AFK[i] < 1800)
				{
				    new minute;
				    new second;
				    minute = floatround(AFK[i] / 60, floatround_floor);
				    second = AFK[i] % 60;
				    format(string, sizeof(string), "%s%d:%02d", string, minute, second);
				}
				if(AFK[i] < 60) { strcat(string," сек."); }
	    		SetPlayerChatBubble(i, string, -1, 25, 1200);
	    	}
		}
		if(AFK[i] == 3000)
		{
		    SCM(i, COLOR_ORANGE, "Превышено максимально допустимое время паузы");
		    Kick(i);
		}
		Checkarmour(i);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if(GetPVarInt(playerid, "logged") == 1) return SpawnPlayer(playerid);
    ResetPlayerMoney(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    clear_player(playerid);
    SCM(playerid, WHITE_COLOR, "Type /help for more information");
	GetPlayerName(playerid, player_info[playerid][NAME], MAX_PLAYER_NAME);
	TogglePlayerSpectating(playerid, 1);
	set_player_default(playerid);
	ResetVariables(playerid);
  	LoadRemovedObjects(playerid);
  	SetPlayerColor(playerid, 0xFFFFFF10);
	
	static const fmt_query[] = "SELECT `password`, `soli` FROM `users` WHERE `name` = '%s'";
	new query[sizeof(fmt_query)+(-2+MAX_PLAYER_NAME)];
	format(query, sizeof(query), fmt_query, player_info[playerid][NAME]);
	mysql_tquery(dbHandle, query, "CheckRegister", "i", playerid);
	
	SetPVarInt(playerid, "WrongPassword", 5);
	
	for(new v; v < MAX_GANGZONE; v++)
		GangZoneShowForPlayer(playerid, GZMZ[v][gCreate], GetGangZoneColor(v));
		
    ///////////////////////SPEEDOMETR/////////////////
	speedbox = TextDrawCreate(626.799987, 397.731109, "usebox");
	TextDrawLetterSize(speedbox, 0.000000, 3.665555);
	TextDrawTextSize(speedbox, 436.399993, 0.000000);
	TextDrawAlignment(speedbox, 1);
	TextDrawColor(speedbox, 0);
	TextDrawUseBox(speedbox, true);
	TextDrawBoxColor(speedbox, 102);
	TextDrawSetShadow(speedbox, 0);
	TextDrawSetOutline(speedbox, 0);
	TextDrawFont(speedbox, 0);

	speed1info[playerid] = TextDrawCreate(442.800079, 398.222167, "SPEED: 0 km/h  HP: 955 HP");
	TextDrawLetterSize(speed1info[playerid], 0.373600, 1.619911);
	TextDrawAlignment(speed1info[playerid], 1);
	TextDrawColor(speed1info[playerid], 0x00FFFFFF);
	TextDrawSetShadow(speed1info[playerid], 0);
	TextDrawSetOutline(speed1info[playerid], 1);
	TextDrawBackgroundColor(speed1info[playerid], 51);
	TextDrawFont(speed1info[playerid], 1);
	TextDrawSetProportional(speed1info[playerid], 1);
////////////////////Default Tags Remove//////////////////////
	RemoveBuildingForPlayer(playerid, 1531, 1799.1328, -1708.7656, 14.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 1732.7344, -963.0781, 41.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1746.7500, -1359.7734, 16.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1687.2266, -1239.1250, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1889.2422, -1982.5078, 15.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2065.4375, -1897.2344, 13.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2763.0000, -2012.1094, 14.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2392.3594, -1914.5703, 14.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2430.3281, -1997.9063, 14.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2587.3203, -2063.5234, 4.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2794.5313, -1906.8125, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2812.9375, -1942.0703, 11.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2162.7813, -1786.0703, 14.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2034.3984, -1801.6719, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1910.1641, -1779.6641, 18.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1837.1953, -1814.1875, 4.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1959.3984, -1577.7578, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2074.1797, -1579.1484, 14.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2182.2344, -1467.8984, 25.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2132.2344, -1258.0938, 24.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2233.9531, -1367.6172, 24.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2224.7656, -1193.0625, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2119.2031, -1196.6172, 24.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1974.0859, -1351.1641, 24.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2093.7578, -1413.4453, 24.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1969.5938, -1289.6953, 24.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1966.9453, -1174.7266, 20.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1911.8672, -1064.3984, 25.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2281.4609, -1118.9609, 27.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2239.7813, -999.7500, 59.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2122.6875, -1060.8984, 25.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2062.7188, -996.4609, 48.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2076.7266, -1071.1328, 27.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2399.4141, -1552.0313, 28.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2353.5391, -1508.2109, 24.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2394.1016, -1468.3672, 24.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2756.0078, -1388.1250, 39.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2767.7813, -1621.1875, 11.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2667.8906, -1469.1328, 31.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2612.9297, -1390.7734, 35.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2536.2188, -1352.7656, 31.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2580.9453, -1274.0938, 46.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2542.9531, -1363.2422, 31.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2522.4609, -1478.7422, 24.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2346.5156, -1350.7813, 24.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2322.4531, -1254.4141, 22.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2273.0156, -1687.4297, 14.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2422.9063, -1682.2969, 13.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2797.9219, -1097.6953, 31.0625, 0.25);
/////////////////////////////////////////

	return 1;
}
forward CheckRegister(playerid);
public CheckRegister(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{
	    cache_get_value_name(0, "password", player_info[playerid][PASSWORD], 65);
	    cache_get_value_name(0, "soli", player_info[playerid][SOLI], 11);
	    ShowLogin(playerid);
	}
	else ShowRegister(playerid);
	
	//InterpolateCameraPos
}

stock ShowLogin(playerid)
{
	new dialog[171+(-2+MAX_PLAYER_NAME)];
	format(dialog, sizeof(dialog),
	    "Welcome back, %s, please print your password below:",
	    player_info[playerid][NAME]);
	SPD(playerid, DLG_LOG, DIALOG_STYLE_PASSWORD, "Login", dialog, "Continue", "");
	KillTimer(LoginTimer[playerid]);
	LoginTimer[playerid] = SetTimerEx("LoginTimeExpired", 30000, false, "d", playerid);

}

forward LoginTimeExpired(playerid);
public LoginTimeExpired(playerid)
{
	if(GetPVarInt(playerid, "logged") == 0)
	{
	    SCM(playerid, RED_COLOR, "Time for login has expired, print '/q' to quit game");
	    SPD(playerid, -1, 0, " ", " ", " ", " ");
	    Kick(playerid);
	}
	return 1;
}

stock ShowRegister(playerid)
{
    new dialog[403+(-2+MAX_PLAYER_NAME)];
    format(dialog, sizeof(dialog),
		"{FFFFFF}Hello, {00f4ff}%s\n\
		 This account is not registered in DataBase!\n\
		 You must create your account.", player_info[playerid][NAME]);
		 
	SPD(playerid, DLG_REG, DIALOG_STYLE_INPUT, "Registration", dialog, "Continue", "Exit");
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(LoginTimer[playerid]);
	if(GetPVarInt(playerid, "logged") != 0)
	{
	    if(player_info[playerid][ADMIN] > 0) Iter_Remove(Admins_ITER, playerid);
    	static const fmt_query[] = "UPDATE `users` SET `minutes` = '%d' WHERE `id` = '%d' LIMIT 1";
		new query[sizeof(fmt_query)+(-2+2)+(-2+11)];
		mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MINUTES], player_info[playerid][ID]);
		mysql_tquery(dbHandle, query);
		if(strlen(player_info[playerid][QUESTION]) > 0)
		{
	    	player_info[playerid][QUESTION] = EOS;
	    	Iter_Remove(Question_ITER, playerid);
		}
	}
	if(inadmcar[playerid] != -1)
	{
	    DestroyVehicle(inadmcar[playerid]);
	    inadmcar[playerid] = -1;
	}
	format(player_info[playerid][SKILLS], 80, "%d,%d,%d",
	player_info[playerid][GUNSKILL][0], player_info[playerid][GUNSKILL][1], player_info[playerid][GUNSKILL][2]);
	static const fmt_query[] = "UPDATE `users` SET `skills`='%s' WHERE `name` = '%s'";
	new query[sizeof(fmt_query)+(-2+50)+(-2+64)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][SKILLS], player_info[playerid][NAME]);
	mysql_tquery(dbHandle, query);
	SaveWeapon(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(GetPVarInt(playerid, "logged") == 0)
	{
	    SCM(playerid, RED_COLOR, "Error, you must login!");
	    return Kick(playerid);
	}
	SetPVarInt(playerid, "logged", 1);
	SetPlayerSkin(playerid, player_info[playerid][SKIN]);
	SetPlayerScore(playerid, player_info[playerid][VOZRAST]);
	SPD(playerid, -1, 0, " ", " ", " ", "");
    SetPlayerPos(playerid, 1243.1615, -1692.5842, 16.1974);
	SetPlayerFacingAngle(playerid, 181.0);
	SetCameraBehindPlayer(playerid);
 	SetPlayerSkills(playerid);
 	SetPlayerColor(playerid, gFractionColor[player_info[playerid][FRACTION]]);

	if(IsAGang(playerid) && is_capture == true)
	{
		TextDrawShowForPlayer(playerid, BandaCapt1a);
		TextDrawShowForPlayer(playerid, BandaCapt2a);
		TextDrawShowForPlayer(playerid, ScoreCapt1a);
		TextDrawShowForPlayer(playerid, ScoreCapt2a);
		TextDrawShowForPlayer(playerid, CaptTime);
		TextDrawShowForPlayer(playerid, ScoreCapt);
		TextDrawShowForPlayer(playerid, Textdraw4);
		GangZoneFlashForPlayer(playerid,GZMZ[captureID][gCreate],GetGZColorF(player_info[playerid][FRACTION]));
	}
	switch(player_info[playerid][FRACTION])
	{
	    case 1: // Grove Spawn
	    {
	        //SetPlayerPos(playerid, 2495.3328, -1686.9163, 13.5149);
	        SetPlayerPos(playerid, 2450.7, -1700.1, 1013.5);
	        SetPlayerFacingAngle(playerid, 2.7612);
	        SetPlayerVirtualWorld(playerid, 1);
   			SetPlayerInterior(playerid, 2);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 2: // Front Yard Ballas Spawn
	    {
	        //SetPlayerPos(playerid, 2467.0559, -1287.9199, 29.5738);
	        SetPlayerPos(playerid, -50.1, 1400.5, 1084.4);
	        SetPlayerFacingAngle(playerid, 89.0359);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 8);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 3: // Varrio Los Aztec Spawn
	    {
	        SetPlayerPos(playerid, 1857.7534, -2031.4261, 13.5469);
	        SetPlayerFacingAngle(playerid, 359.3967);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 4: // San Fierro Rifa Spawn
	    {
	        SetPlayerPos(playerid, -2613.2830, -134.6033, 4.3359);
	        SetPlayerFacingAngle(playerid, 269.0261);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 5: // Los Santos Vagos Spawn
	    {
	        //SetPlayerPos(playerid, 2745.9951, -1205.5792, 67.2822);
	        SetPlayerPos(playerid, 2372.7, -1126.6, 1050.9);
	        SetPlayerFacingAngle(playerid, 87.1364);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 8);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 6: // Seville B.L.V.D Spawn
	    {
	        SetPlayerPos(playerid, 2784.1963, -1926.2349, 13.5469);
	        SetPlayerFacingAngle(playerid, 89.2626);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 7: // Rollin Heightz Ballas Spawn
	    {
	        SetPlayerPos(playerid, 893.8895, -1643.4985, 13.5469);
	        SetPlayerFacingAngle(playerid, 178.4964);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 8: // Temple Drive Ballas Spawn
	    {
	        //SetPlayerPos(playerid, 1149.4561, -1078.7603, 27.8569);
	        SetPlayerPos(playerid, 2342, -1064.1, 1049);
	        SetPlayerFacingAngle(playerid, 267.6600);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 6);
	        SetCameraBehindPlayer(playerid);
	    }
	    case 9: // Kilo Tray Ballas Spawn
	    {
	        //SetPlayerPos(playerid, 1999.9841, -1120.4426, 26.7813);
	        SetPlayerPos(playerid, 224, 1291.9, 1082.1);
	        SetPlayerFacingAngle(playerid, 178.7932);
	        SetPlayerVirtualWorld(playerid, 0);
   			SetPlayerInterior(playerid, 1);
	        SetCameraBehindPlayer(playerid);
	    }
	}
	
	/*if (Hospitalized[playerid] == 1)
	{
		hospitaltimer = SetTimer("HospitalTimer", 5000, false);
		TogglePlayerControllable(playerid,0);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1169.9645, -1323.8893, 15.6929);
		SetPlayerCameraPos(playerid, 1201.5150, -1323.3530, 24.7329);
		SetPlayerCameraLookAt(playerid, 1173.2358, -1323.2872, 19.4348);
		SendClientMessage(playerid, WHITE_COLOR, "(( You must stay {"#cRE"}10{FFFFFF} seconds at the hospital to recover. ))");
		GameTextForPlayer(playerid, "~n~~b~Recovering...", 5000, 3);
	}*/
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    AFK[playerid] = -2;
    new bandkiller;
	new bandkill;
    KillTimer(narcotimer);
    KillTimer(tagtimer);
    NarkoTimer(playerid);
    Hospitalized[playerid] = 1;
    if(killerid != INVALID_PLAYER_ID)
    {
		if(player_info[killerid][FRACTION] !=0)
		{
			bandkiller = player_info[killerid][FRACTION];
		}
		else
		{
			bandkiller = player_info[killerid][FRACTION];
		}
		if(player_info[killerid][FRACTION] !=0)
		{
			bandkill = player_info[playerid][FRACTION];
		}
		else
		{
			bandkill = player_info[playerid][FRACTION];
		}
		if(bandkiller != bandkill)
		{
			if(GangInfo[bandkiller][capture] && GangInfo[bandkill][capture] == 1)
			{
				if(GangInfo[bandkiller][captureid] == GangInfo[bandkill][captureid])
				{
				    SendDeathMessage(killerid, playerid, reason);
					GangInfo[bandkiller][score] = GangInfo[bandkiller][score]+1;
					CaptureUpd(bandkiller);
				}
			}
		}
		if(IsAGang(playerid) && is_capture == true)
		{
			GangZoneFlashForPlayer(playerid,GZMZ[captureID][gCreate],GetGZColorF(player_info[playerid][FRACTION]));
		}
	}
	for(new i; i < 13; i++)
    {
            player_info[playerid][WEAPONID][i] = 0;
            player_info[playerid][AMMOS][i] = 0;
    }
	return 1;
}
stock CaptureUpd(bandkiller)
{
	new str_score1[64], str_score2[64];
	foreach(new i:Player)
	{
		if(!IsAGang(i)) continue;
		if(GangInfo[bandkiller][gangnumber] == 1)
		{
			format(str_score1, 64, "%d", GangInfo[bandkiller][score]);
			TextDrawSetString(ScoreCapt1a, str_score1);
		}
		else
		{
			format(str_score2, 64, "%d", GangInfo[bandkiller][score]);
			TextDrawSetString(ScoreCapt2a, str_score2);
		}
	}
}
public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid, "logged") == 0)
	{
	    SCM(playerid, RED_COLOR, "Error, you must login for chatting!");
	    return Kick(playerid);
	}
	new string[144];
	if(strlen(text) < 113)
	{
	    format(string, sizeof(string), "%s[%d] сказал: %s", player_info[playerid][NAME], playerid, text);
	    ProxDetector(20.0, playerid, string, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR);
	    SetPlayerChatBubble(playerid, text, WHITE_COLOR, 20, 7500);
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
	        ApplyAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1);
	        SetTimerEx("StopChatAnim", 3200, false, "d", playerid);
	    }
	}
	else
	{
	    SCM(playerid, WHITE_COLOR, "Your message is too long");
	    return 0;
	}
	return 0;
}

forward StopChatAnim(playerid);
public StopChatAnim(playerid)
{
	ApplyAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
forward speedupdate(playerid);
public speedupdate(playerid)
{
 	foreach(new i:Player)
 	{
		new Float:vehheal;
		GetVehicleHealth(GetPlayerVehicleID(i), vehheal);
		new string[64];
		format(string, sizeof(string), "SPEED: ~b~~h~~h~%d km/h  ~w~HP: ~b~~h~~h~%.0f", SpeedVehicle(i), vehheal);
		TextDrawSetString(speed1info[i], string);
 	}
}
stock SpeedVehicle(playerid)
{
    new Float: ST[4];
    new carid = GetPlayerVehicleID(playerid);
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(carid,ST[0],ST[1],ST[2]);
	else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 100.3;
    return floatround(ST[3]);
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER)
	{
	    if(inadmcar[playerid] != -1)
	    {
			DestroyVehicle(inadmcar[playerid]);
			inadmcar[playerid] = -1;
	    }
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    TextDrawShowForPlayer(playerid, speedbox);
	    TextDrawShowForPlayer(playerid, speed1info[playerid]);
	    speedupdate(playerid);
		timespeed[playerid] = SetTimerEx("speedupdate", 500, true, "i", playerid);
		/*new Float:health;
		GetPlayerHealth(playerid, health);
		if(health < 0)
		{
		    TextDrawHideForPlayer(playerid, speedbox);
	    	TextDrawHideForPlayer(playerid, speed1info[playerid]);
		}*/
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 5)
	    {
	        if(player_info[playerid][FRACTION] != 5 && player_info[playerid][LFRACTION] != 5)
	        {
		        SCM(playerid, 0xFFD80765, "Car is assigned to Los Santos Vagos");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 4)
	    {
	        if(player_info[playerid][FRACTION] != 4 && player_info[playerid][LFRACTION] != 4)
	        {
		        SCM(playerid, 0x1400FF85, "Car is assigned to San Fierro Rifa");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 1)
	    {
	        if(player_info[playerid][FRACTION] != 1 && player_info[playerid][LFRACTION] != 1)
	        {
		        SCM(playerid, 0x3FDB3765, "Car is assigned to Grove Street");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 2)
	    {
	        if(player_info[playerid][FRACTION] != 2 && player_info[playerid][LFRACTION] != 2)
	        {
		        SCM(playerid, 0xEE15FF90, "Car is assigned to Front Yard Ballas");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 3)
	    {
	        if(player_info[playerid][FRACTION] != 3 && player_info[playerid][LFRACTION] != 3)
	        {
		        SCM(playerid, 0x00EBFF65, "Car is assigned to Varrio Los Aztecas");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 6)
	    {
	        if(player_info[playerid][FRACTION] != 6 && player_info[playerid][LFRACTION] != 6)
	        {
		        SCM(playerid, 0x00FF7F85, "Car is assigned to Seville B.L.V.D Families");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 7)
	    {
	        if(player_info[playerid][FRACTION] != 7 && player_info[playerid][LFRACTION] != 7)
	        {
		        SCM(playerid, 0xFF007F85, "Car is assigned to Rollin Heightz Ballas");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 8)
	    {
	        if(player_info[playerid][FRACTION] != 8 && player_info[playerid][LFRACTION] != 8)
	        {
		        SCM(playerid, 0xEE84FF90, "Car is assigned to Temple Drive Ballas");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] == 9)
	    {
	        if(player_info[playerid][FRACTION] != 9 && player_info[playerid][LFRACTION] != 9)
	        {
		        SCM(playerid, 0x9F00FF55, "Car is assigned to Kilo Tray Ballas");
		        RemovePlayerFromVehicle(playerid);
	        }
	    }
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		TextDrawHideForPlayer(playerid, speedbox);
	    TextDrawHideForPlayer(playerid, speed1info[playerid]);
	}

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    DisablePlayerCheckpoint(playerid);
    SCM(playerid, COLOR_LIGHTBLUE, "You have arrived at destination");
	PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}



public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP pickupid)
{
	if(!IsValidDynamicPickup(pickupid) || pPickupID[playerid]) return 0;
	pPickupID[playerid] = pickupid;
	if(pPickupID[playerid] == TDBallaspickup[0])
	{
	    SetPlayerFacingAngle(playerid, 269.0261);
	    //if(player_info[playerid][FRACTION] != 8) return SCMError(playerid, "You're not available to enter this house");
	    SetPlayerPos(playerid, 1139.2090, -1078.8229, 29.3603);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == TDBallaspickup[1])
	{
	    SetPlayerPos(playerid, 2333.1165, -1074.8962, 1049.0234);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 6);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == FYBallaspickup[0])
	{
	    SetPlayerPos(playerid, 2467.0559, -1287.9199, 29.5738);
	    SetPlayerFacingAngle(playerid, 100.9110);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == FYBallaspickup[1])
	{
	    SetPlayerPos(playerid, -42.3202, 1407.7455, 1084.4297);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 8);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == blackmarketgunpickup)
	{
	    SPD(playerid, DLG_BLACKMARKETMES, DIALOG_STYLE_MSGBOX, !"Black Market", !"Do you wish to sell or buy guns?", !"Buy", !"Sell");
	}
	if(pPickupID[playerid] == emmetpickupenter)
	{
	    if(!IsAGang(playerid)) return SCMError(playerid, "Emmet: I dont know you, go and fuck yourself (( Not a gang member ))");
	    else
	    {
		    SetPlayerPos(playerid, 446.20001, 510.29999, 1001.4);
		    SetPlayerFacingAngle(playerid, 6.2247);
		    SetPlayerVirtualWorld(playerid, 0);
		    SetPlayerInterior(playerid, 12);
		    SetCameraBehindPlayer(playerid);
	    }
	}
	if(pPickupID[playerid] == emmetpickupexit)
	{
	    SetPlayerPos(playerid, 2447.9563, -1965.3480, 13.5469);
	    SetPlayerFacingAngle(playerid, 183.1803);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == GSFpickup[0])
	{
	    SetPlayerPos(playerid, 2459.3179, -1687.4020, 13.5398);
	    SetPlayerFacingAngle(playerid, 6.2247);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == GSFpickup[1])
	{
	    SetPlayerPos(playerid, 2465.0776, -1698.2059, 1013.5078);
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 2);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == LSVpickup[0])
	{
	    SetPlayerPos(playerid, 2756.3975, -1179.9109, 69.3985);
	    SetPlayerFacingAngle(playerid, 359.3665);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == LSVpickup[1])
	{
	    SetPlayerPos(playerid, 2365.1965, -1133.0120, 1050.8750);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 8);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == KTBallaspickup[0])
	{
	    SetPlayerPos(playerid, 1999.9841, -1120.4426, 26.7813);
	    SetPlayerFacingAngle(playerid, 182.6525);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == KTBallaspickup[1])
	{
	    SetPlayerPos(playerid, 223.1278, 1289.4697, 1082.1328);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 1);
	    SetCameraBehindPlayer(playerid);
	}
	if(pPickupID[playerid] == fraccarbuy)
	{
	    if(!(1 <= player_info[playerid][FRACTION] <= 9)) return SCMError(playerid, "Black Market is not available");
	    if(player_info[playerid][FRACTIONRANG] < 9) return SCMError(playerid, "You must be at least rank 9");
	    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] < 1) return SCMError(playerid, "This is not a gang-fraction car");
	    SPD(playerid, DLG_FRACCARCHOOSE, DIALOG_STYLE_MSGBOX, "Fraction Car Change",
		 "You want to buy a new car instead of that?",
		 "Yes", "No");
	}
	if(pPickupID[playerid] == infonoobs)
	{
	    SPD(playerid, DLG_NOOBS, DIALOG_STYLE_LIST, "{"#cBL"}INFORMATION / GPS",
		"{"#cBL"}1.{FFFFFF} Gangs and Mafia",
		"Выбрать", "Выход");
	}
	// Пикапы, которые не должны флудить действиями
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	
    /* if(pickupid == minenter)
   		{
   		    SetPlayerPos(playerid, X, Y, Z);
   		    SetPlayerFacingAngle(playerid, 0.0);
   		    SetPlayerVirtualWorld(playerid, virtualworld(1));
   		    SetPlayerInterior(playerid, interior(1));
   		    SetCameraBehindPlayer(playerid);
	    }
		   */
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    if(newinteriorid != 0 && oldinteriorid == 0)
	{
		SetPlayerTime(playerid, 12, 0);
	}
	else
	{
	    //gCurDay = GetDayNumber();
		new h;
		gettime(h,gCurMinutes,gCurHour);
		SetPlayerTime(playerid, h, 0);
	}
	return 1;
}
forward KeyCheck(playerid);
public KeyCheck(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new keys, ud, lr;

        GetPlayerKeys(playerid, keys, ud, lr);

        if(keys & KEY_FIRE)
        {
	        if(IsAGang(playerid))
		    {
		        //new ammo = GetPlayerAmmo(playerid);
		        //GetPlayerWeaponData(playerid, 9, 41
		     	if(GetPlayerWeapon(playerid) == 41)
			    {
			        for(new gtags; gtags < MAXGANGTAGS; gtags++)
					{

				    	if(IsPlayerInRangeOfPoint(playerid, 2.0, gangtags_info[gtags][gtCoords1], gangtags_info[gtags][gtCoords2], gangtags_info[gtags][gtCoords3]))
				    	{
				    	    if(gangtags_info[gtags][gfraction] == player_info[playerid][FRACTION])
							{
						    	KillTimer(tagtimer);
								SCMError(playerid, "You cant respray tag of your gang");
							}
				    	    new string[150], ftext[60];
				    	    if(gangtags_info[gtags][gfraction] != player_info[playerid][FRACTION])
							{
					    	    switch(gangtags_info[gtags][gfraction])
					    	    {
									case 1: ftext = "{"#cGR"}Grove Street Families{FFFFFF}";
									case 2: ftext = "{"#cPINK"}Front Yard Ballas{FFFFFF}";
									case 3: ftext = "{"#cLIGHTBLUE"}Varrio Los Aztecas{FFFFFF}";
									case 4: ftext = "{"#cBLUE"}San Fierro Rifa{FFFFFF}";
									case 5: ftext = "{"#cYELLOW"}Los Santos Vagos{FFFFFF}";
									case 6: ftext = "{"#cLIGHTGREEN"}Seville B.L.V.D Families{FFFFFF}";
									case 7: ftext = "{"#cPINK"}Rollin Heightz Ballas{FFFFFF}";
									case 8: ftext = "{"#cPINK"}Temple Drive Ballas{FFFFFF}";
									case 9: ftext = "{"#cPINK"}Kilo Tray Ballas{FFFFFF}";
					    	    }
						        format(string, sizeof(string), "Current graffiti belongs to %s\nDo you want to respray that graffiti for your gang?", ftext);
								SPD(playerid, DLG_GANGTAG, DIALOG_STYLE_MSGBOX, !"Graffiti", string, !"Yes", !"No");
					        }
			    		}
				    }
				}
		    }
        }
    }
    HoldingKey[playerid] = false;
    return 0;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK)
	{
		callcmd::showstats(playerid);
	}
	/*if(newkeys & KEY_FIRE)
	{
	    if(IsAGang(playerid))
	    {
	        //new ammo = GetPlayerAmmo(playerid);
	        //GetPlayerWeaponData(playerid, 9, 41
	     	if(GetPlayerWeapon(playerid) == 41)
		    {
		        for(new gtags; gtags < MAXGANGTAGS; gtags++)
				{
			    	if(IsPlayerInRangeOfPoint(playerid, 2.0, gangtags_info[gtags][gtCoords][0], gangtags_info[gtags][gtCoords][1], gangtags_info[gtags][gtCoords][2]))
			    	{
			    	    new string[150], ftext[60];
			    	    switch(gangtags_info[gtags][gfraction])
			    	    {
							case 1: ftext = "{"#cGR"}Grove Street Families{FFFFFF}";
							case 2: ftext = "{"#cPINK"}Front Yard Ballas{FFFFFF}";
							case 3: ftext = "{"#cLIGHTBLUE"}Varrio Los Aztecas{FFFFFF}";
							case 4: ftext = "{"#cBLUE"}San Fierro Rifa{FFFFFF}";
							case 5: ftext = "{"#cYELLOW"}Los Santos Vagos{FFFFFF}";
							case 6: ftext = "{"#cLIGHTGREEN"}Seville B.L.V.D Families{FFFFFF}";
							case 7: ftext = "{"#cPINK"}Rollin Heightz Ballas{FFFFFF}";
							case 8: ftext = "{"#cPINK"}Temple Drive Ballas{FFFFFF}";
							case 9: ftext = "{"#cPINK"}Kilo Tray Ballas{FFFFFF}";
			    	    }
			    	    format(string, sizeof(string), "Current graffiti belongs to %s\nDo you want to respray that graffiti for your gang?", ftext);
						SPD(playerid, DLG_GANGTAG, DIALOG_STYLE_MSGBOX, !"Graffiti", string, !"Yes", !"No");
		    		}
			    }
			}
	    }
	}*/
	if(newkeys & KEY_FIRE && !HoldingKey[playerid])
    {
        HoldingKey[playerid] = true;
        tagtimer = SetTimerEx("KeyCheck", 3000, 0, "i", playerid);
    }
    /*if(newkeys & KEY_YES)
	{
    if(player_info[playerid][SHOWSKILLAC] == playerid)
	    {
	        new acter = player_info[playerid][SHOWSKILLPL];
			new strkill[406];
			new points[3];
			points[0] = 100 - player_info[acter][GUNSKILL][0];
			points[1] = 100 - player_info[acter][GUNSKILL][1];
			points[2] = 100 - player_info[acter][GUNSKILL][2];
			//points[3] = 100 - player_info[acter][GUNSKILL][3];
			format(strkill,406,"{"#cW"}Pistol:\t\t[%s]%d\nDeagle:\t[%s]%d\nMicroUZI",
			ToDevelopSkills(player_info[acter][GUNSKILL][0],points[0]), player_info[acter][GUNSKILL][0],
			ToDevelopSkills(player_info[acter][GUNSKILL][1],points[1]), player_info[acter][GUNSKILL][1],
			ToDevelopSkills(player_info[acter][GUNSKILL][2],points[2]), player_info[acter][GUNSKILL][2]);
			//ToDevelopSkills(player_info[acter][GUNSKILL][3],points[3]), player_info[acter][GUNSKILL][3]);
			SPD(playerid,DLG_MES,0,"{"#cYELLOW"}Навыки владения оружием",strkill,"Закрыть","");
       		new mese[64];
			format(mese,sizeof(mese),"показал выписку из тира %s'y",player_info[playerid][NAME]);
			MeAction(acter,mese);
			player_info[playerid][SHOWSKILLAC] = -1;
	    }
	}
    if(newkeys & KEY_NO)
	{
	    if(player_info[playerid][SHOWSKILLAC] == playerid)
	    {
			SendClientMessage(playerid,-1,"Вы отказались от предложения");
			SendClientMessage(player_info[playerid][SHOWSKILLPL],-1,"Игрок отказался от предложения");
			player_info[playerid][SHOWSKILLAC] = -1;
	    }
	}*/
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(AFK[playerid] > -2)
	{
	    if(AFK[playerid] > 2) SetPlayerChatBubble(playerid, "", -1, 25.0, 200);
	    AFK[playerid] = 0;
	}
	if(pPickupID[playerid])
	{
	    new pickupid = pPickupID[playerid];
		if(!IsValidDynamicPickup(pickupid)) pPickupID[playerid] = 0;
		else
		{
			new Float:pos_x, Float:pos_y, Float:pos_z;
			Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, pos_x);
			Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, pos_y);
			Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, pos_z);
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, pos_x, pos_y, pos_z)) pPickupID[playerid] = 0;
		}
	}
    AFK[playerid] = 0;
    if(GetPlayerMoney(playerid) != player_info[playerid][MONEY])
	{
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid, player_info[playerid][MONEY]);
	}
	iNewPlayerAmmo[playerid] = GetPlayerAmmo(playerid);
	if(iNewPlayerAmmo[playerid] != iPlayerAmmo[playerid])
	{
		OnPlayerAmmoChange(playerid, iNewPlayerAmmo[playerid], iPlayerAmmo[playerid]);
		iPlayerAmmo[playerid] = iNewPlayerAmmo[playerid];
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DLG_REG:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext))
	            {
	                ShowRegister(playerid);
	                return SCM(playerid, RED_COLOR, "Warning! Write your password and press 'Continue' !");
	            }
	            if(!(8 <= strlen(inputtext) <= 32))
	            {
	            	ShowRegister(playerid);
	                return SCM(playerid, RED_COLOR, "Your password must be more than 8 letters and less than 24 letters!");
	            }
	            new regex:rg_passwordcheck = regex_new("^[a-zA-Z0-9]{1,}$");
	            if(regex_check(inputtext, rg_passwordcheck))
	            {
	                new k[11];
	                for(new i; i < 10; i++)
	                {
	                    k[i] = random(79) + 47;
	                }
	                k[10] = 0;
	                strmid(player_info[playerid][PASSWORD], inputtext, 0, strlen(inputtext), 32);
	                SHA256_PassHash(inputtext, k, player_info[playerid][PASSWORD], 65);
	                strmid(player_info[playerid][SOLI], k, 0, 11, 11);
	                SCM(playerid, RED_COLOR, "Password created! ");
					SPD(playerid, DLG_REGEMAIL, DIALOG_STYLE_INPUT, "Registration: Email Address", "Email", "Continue", "");
				}
	            else
	            {
	                ShowRegister(playerid);
	                regex_delete(rg_passwordcheck);
	                return SCM(playerid, RED_COLOR, "Warning! Your password must be letters and numbers!");
	            }
	            regex_delete(rg_passwordcheck);
	        }
	        else
	        {
	            SCM(playerid, RED_COLOR, "Print \"/q\" in chat to exit game");
	            SPD(playerid, -1, 0, " ", " ", " ", "");
	            return Kick(playerid);
	        }
	    }
	    case DLG_REGEMAIL:
	    {
	        if(!strlen(inputtext))
	        {
	            SPD(playerid, DLG_REGEMAIL, DIALOG_STYLE_INPUT, "Registration: Email Address", "Email", "Continue", "");
	            return SCM(playerid, RED_COLOR, "Warning! Write your Email and press 'Continue' !");
	        }
	        new regex:rg_emailcheck = regex_new("^[a-zA-Z0-9.-_]{1,43}@[a-zA-Z]{1,12}.[a-zA-Z]{1,8}$");
	        if(regex_check(inputtext, rg_emailcheck))
	        {
	            strmid(player_info[playerid][EMAIL], inputtext, 0, strlen(inputtext), 64);
	            SPD(playerid, DLG_REGSEX, DIALOG_STYLE_MSGBOX, "Select Sex", "Select your sex", "Male", "Female");
	        }
	        else
	        {
	            SPD(playerid, DLG_REGEMAIL, DIALOG_STYLE_INPUT, "Registration: Email Address", "Email", "Continue", "");
	            regex_delete(rg_emailcheck);
	            return SCM(playerid, RED_COLOR, "Warning! Write your Email and press 'Continue' !");
	        }
	        regex_delete(rg_emailcheck);
	    }
	        case DLG_REGSEX:
	        {
	            player_info[playerid][SEX] = (response) ? (1) : (2);
	            SPD(playerid, DLG_REGRACE, DIALOG_STYLE_LIST, "Select your character Race", "Negroid\nEuropoid\nMongoloid", "Continue", "");
	        }
	        case DLG_REGRACE:
	        {
	            player_info[playerid][RACE] = listitem+1;
	            SPD(playerid, DLG_REGAGE, DIALOG_STYLE_INPUT, "Select your character Age", "Print your character age ( 14 - 70 years )", "Continue", "");
	        }
	        case DLG_REGAGE:
	        {
	            if(!strlen(inputtext))
	            {
	                SPD(playerid, DLG_REGAGE, DIALOG_STYLE_INPUT, "Select your character Age", "Print your character age ( 14 - 70 years )", "Continue", "");
	                return SCM(playerid, RED_COLOR, "Warning! Print your character age properly ( 14 - 70 years )");
	            }
				if(!(14 <= strval(inputtext) <= 70))
	            {
	                SPD(playerid, DLG_REGAGE, DIALOG_STYLE_INPUT, "Select your character Age", "Print your character age ( 14 - 70 years )", "Continue", "");
	            }
	            player_info[playerid][AGE] = strval(inputtext);
	            
	            new maleskinsreg[9][4] =
	            {
					{19, 21, 22, 28},
					{24, 25, 36, 67},
					{14, 142, 182, 183},
					{29, 96, 101, 26},
					{2, 37, 72, 202},
					{1, 3, 234, 290},
					{23, 60, 170, 180},
					{20, 47, 48, 206},
					{44, 58, 132, 229}
	            };
	            
	            new femaleskinsreg[9][2] =
	            {
	                {13, 69},
	                {9, 190},
	                {10, 218},
	                {41, 56},
	                {31, 151},
	                {39, 89},
	                {169, 193},
	                {207, 225},
	                {54, 130}
	            };
				new regskin;
				switch(player_info[playerid][RACE])
				{
					   case 1: {}
					   case 2: regskin+=3;
					   case 3: regskin+=6;
				}
				switch(player_info[playerid][AGE])
				{
					   case 14..29: {}
					   case 30..45: regskin++;
					   case 46..70: regskin+=2;
				}
            	if(player_info[playerid][SEX] == 1) player_info[playerid][SKIN] = maleskinsreg[regskin][random(4)];
				else player_info[playerid][SEX] = femaleskinsreg[regskin][random(2)];
				SCM(playerid, WHITE_COLOR, "Registration finished, Good Luck!");
				new Year, Month, Day;
				getdate(Year, Month, Day);
				new date[13];
				format(date, sizeof(date), "%02d.%02d.%d", Day, Month, Year);
				new ip[16];
				GetPlayerIp(playerid, ip, sizeof(ip));
				static const fmt_query[] = "INSERT INTO `users` (`name`, `password`, `soli`, `email`, `race`, `age`, `sex`, `skin`, `regdata`, `regip`, `skills`) VALUES ('%s', '%s', '%s', '%s', '%d', '%d', '%d', '%d', '%s', '%s', '0,0,0')";
				new query[sizeof(fmt_query)+(-2+MAX_PLAYER_NAME)+(-2+64)+(-2+10)+(-2+64)+(-2+8)+(-2+1)+(-2+2)+(-2+1)+(-2+3)+(-2+12)+(-2+15)+(-2+100)];
				format(query, sizeof(query), fmt_query, player_info[playerid][NAME], player_info[playerid][PASSWORD], player_info[playerid][SOLI], player_info[playerid][EMAIL], player_info[playerid][RACE], player_info[playerid][AGE], player_info[playerid][SEX], player_info[playerid][SKIN], player_info[playerid][REGDATA], player_info[playerid][REGIP]);
				mysql_query(dbHandle, query);
				static const fmt_query2[] = "SELECT * FROM `users` WHERE `name` = '%s' AND `password` = '%s'";
				format(query, sizeof(query), fmt_query2, player_info[playerid][NAME], player_info[playerid][PASSWORD]);
				mysql_tquery(dbHandle, query, "PlayerLogin", "i", playerid);
	        }
	        case DLG_LOG:
	        {
	            if(response)
	            {
	                if(!strlen(inputtext))
	                {
	                    ShowLogin(playerid);
	                    return 1;
	                }
	                new checkpass[65];
	                SHA256_PassHash(inputtext, player_info[playerid][SOLI], checkpass, 65);
					if(strcmp(player_info[playerid][PASSWORD], checkpass, false, 64) == 0)
					{
					    static const fmt_query[] = "SELECT * FROM `users` WHERE `name` = '%s' AND `password` = '%s'";
					    new query[sizeof(fmt_query)+(-2+MAX_PLAYER_NAME)+(-2+64)+(-2+10)+(-2+64)];
						format(query, sizeof(query), fmt_query, player_info[playerid][NAME], player_info[playerid][PASSWORD]);
						mysql_tquery(dbHandle, query, "PlayerLogin", "i", playerid);
					}
					else
					{
					    new string[100];
					    SetPVarInt(playerid, "WrongPassword", GetPVarInt(playerid, "WrongPassword") - 1);
					    if(GetPVarInt(playerid, "WrongPassword") > 0)
					    {
					    	format(string, sizeof(string), "Wrong Password, you have %d more try", GetPVarInt(playerid, "WrongPassword"));
					    	SCM(playerid, RED_COLOR, string);
					    	ShowLogin(playerid);
					    }
						if(GetPVarInt(playerid, "WrongPassword") == 0)
						{
					    	SCM(playerid, RED_COLOR, "You have been kicked after 5 wrong attempts");
                            SPD(playerid, -1, 0, " ", " ", " ", "");
							return Kick(playerid);
					    }
					}
	            }
	            else
				{
					SCM(playerid, RED_COLOR, "Print \"/q\" in chat to exit game");
	            	SPD(playerid, -1, 0, " ", " ", " ", "");
	            	return Kick(playerid);
				}
	        }
	        /*case DLG_STATS:
	        {
	            if(response)
	            {
	                callcmd::showstats(playerid);
	            }
	        }*/
	        case DLG_REPORT:
	        {
	            if(response)
	            {
	                switch(listitem)
	                {
	                    case 0:
	                    {
	                        SPD(playerid, DLG_VOPROS, DIALOG_STYLE_INPUT, !"Type your question", !"cheto {ff0000}tam", !"Send", !"Back");
	                    }
	                    case 1:
	                    {
	                        SPD(playerid, DLG_JALOBA, DIALOG_STYLE_INPUT, !"Type your jalobablyat", !"cheto {ff0000}tam", !"Send", !"Back");
	                    }
	                }
	            }
	            else callcmd::showstats(playerid);
	        }
	        case DLG_NOOBS:
	        {
	            if(response)
	            {
	                switch(listitem)
	                {
	                    case 0:
	                    {
							SPD(playerid, DLG_GPSNOOBS, DIALOG_STYLE_LIST, !"Select Gang/Mafia",
							 !"{FFFFFF} 1. {"#cBL"} Grove Street\n{FFFFFF} 2. {"#cBL"} Front Yard Ballas\n{FFFFFF} 3. {"#cBL"} Varrio Los Aztecas\n{FFFFFF} 4. {"#cBL"} San Fierro Rifa\n{FFFFFF} 5. {"#cBL"} Los Santos Vagos\n{FFFFFF} 6. {"#cBL"} Seville B.L.V.D Families\n{FFFFFF} 7. {"#cBL"} Rollin Heightz Ballas\n{FFFFFF} 8. {"#cBL"} Temple Drive Ballas\n{FFFFFF} 9. {"#cBL"} Kilo Tray Ballas",
							  !"Select", !"Exit");
	                    }
	                }
	            }
	            else
	            {
	            	SPD(playerid, -1, 0, " ", " ", " ", "");
				}
	        }
	        case DLG_BLACKMARKETMES:
	        {
	            if(response) SPD(playerid, DLG_BLACKMARKETGUN, DIALOG_STYLE_TABLIST_HEADERS, !"Emmet",
				!"Weapon\tPrice\tBullets\n\
				Pistol\t{"#cBL"}$340\t50\n\
				Tec9\t{"#cBL"}$475\t100\n\
				MicroUZI\t{"#cBL"}$475\t100", !"Buy", !"Exit");
				else SPD(playerid, DLG_BLACKMARKETGUNSELL, DIALOG_STYLE_TABLIST_HEADERS, !"Emmet BUY PRICE",
				!"Weapon\tBullets\tPrice\n\
				Pistol\t1\t{"#cBL"}$3\n\
				Tec9\t1\t{"#cBL"}$2\n\
				MicroUZI\t1\t{"#cBL"}$2", !"Sell", !"Exit");
	        }
	        case DLG_BLACKMARKETGUNSELL:
	        {
	            if(response)
	            {
	                switch(listitem)
	                {
	                    case 0: SPD(playerid, DLG_BLACKMARKETGUNSELLP, DIALOG_STYLE_INPUT, !"Selling Pistol", !"Input ammount", !"Sell", !"Back");
	                    case 1: SPD(playerid, DLG_BLACKMARKETGUNSELLT, DIALOG_STYLE_INPUT, !"Selling Tec9", !"Input ammount", !"Sell", !"Back");
	                    case 2: SPD(playerid, DLG_BLACKMARKETGUNSELLM, DIALOG_STYLE_INPUT, !"Selling MicroUZI", !"Input ammount", !"Sell", !"Back");
	                }
	            }
				else SPD(playerid, -1, 0, " ", " ", " ", "");
	        }
	        case DLG_BLACKMARKETGUNSELLP:
	        {
	            new weap, ammount;
	            new amount = strval(inputtext);
	            GetPlayerWeaponData(playerid, 2, weap, ammount);
	            if(response)
	            {
	                if(amount > ammount) SPD(playerid, -1, 0, " ", " ", " ", ""), SCMError(playerid, "Emmet: You're tryin' fuck with me? You dont have bullets.");
	                else
	                {
		                player_info[playerid][MONEY] += amount*3;
		                GivePlayerWeapon(playerid, 22, -amount);
		                SaveWeapon(playerid);
		                static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
						new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
						mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
						mysql_query(dbHandle, query);
						new string[50];
						format(string, sizeof(string), "You sold Pistol for $%d", amount*3);
						SCM(playerid, COLOR_LIGHTBLUE, string);
					}
	            }
	        }
	        case DLG_BLACKMARKETGUNSELLT:
	        {
	            new weap, ammount;
	            new amount = strval(inputtext);
	            GetPlayerWeaponData(playerid, 4, weap, ammount);
	            
	            if(response)
	            {
	                if(amount > ammount) SPD(playerid, -1, 0, " ", " ", " ", ""), SCMError(playerid, "Emmet: You're tryin' fuck with me? You dont have bullets.");
	                else
	                {
		                player_info[playerid][MONEY] += amount*2;
		                GivePlayerWeapon(playerid, 32, -amount);
		                SaveWeapon(playerid);
		                static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
						new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
						mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
						mysql_query(dbHandle, query);
						new string[50];
						format(string, sizeof(string), "You sold Tec9 for $%d", amount*2);
						SCM(playerid, COLOR_LIGHTBLUE, string);
					}
	            }
	        }
	        case DLG_BLACKMARKETGUNSELLM:
	        {
	            new amount = strval(inputtext);
	            new weap, ammount;
	            GetPlayerWeaponData(playerid, 4, weap, ammount);
	            if(response)
	            {
	                if(amount > ammount) SPD(playerid, -1, 0, " ", " ", " ", ""), SCMError(playerid, "Emmet: You're tryin' fuck with me? You dont have bullets.");
	                else
	                {
		                player_info[playerid][MONEY] += amount*2;
		                GivePlayerWeapon(playerid, 28, -amount);
		                SaveWeapon(playerid);
		                static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
						new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
						mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
						mysql_query(dbHandle, query);
						new string[50];
						format(string, sizeof(string), "You sold MicroUZI for $%d", amount*2);
						SCM(playerid, COLOR_LIGHTBLUE, string);
					}
	            }
	        }
	        case DLG_BLACKMARKETGUN:
	        {
	            if(response)
	            {
		            switch(listitem)
		            {
		               case 0: GivePlayerWeapon(playerid, 22, 50), player_info[playerid][MONEY] -=340;
		               case 1: GivePlayerWeapon(playerid, 32, 100), player_info[playerid][MONEY] -=475;
		               case 2: GivePlayerWeapon(playerid, 28, 100), player_info[playerid][MONEY] -=475;
		            }
		            static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
					new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
					mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
					mysql_query(dbHandle, query);
	            }
	            else SPD(playerid, -1, 0, " ", " ", " ", "");
	        }
	        case DLG_GANGTAG:
	        {
	            if(response)
	            {
					for(new gtags; gtags < MAXGANGTAGS; gtags++)
					{
					    if(IsPlayerInRangeOfPoint(playerid, 2.0, gangtags_info[gtags][gtCoords1], gangtags_info[gtags][gtCoords2], gangtags_info[gtags][gtCoords3]))
					    {
					        new ftext[60];
							switch(player_info[playerid][FRACTION])
							{
							    case 1: gangtags_info[gtags][gtmodel] = 18659, gangtags_info[gtags][gfraction] = 1, ftext = "~g~Tag Nr.%d resprayed~n~ +15$";
							    case 2: gangtags_info[gtags][gtmodel] = 18666, gangtags_info[gtags][gfraction] = 2, ftext = "~p~Tag Nr.%d resprayed~n~ +15$";
								case 3: gangtags_info[gtags][gtmodel] = 1531, gangtags_info[gtags][gfraction] = 3, ftext = "~b~~h~~h~Tag Nr.%d resprayed~n~ +15$";
							    case 4: gangtags_info[gtags][gtmodel] = 18663, gangtags_info[gtags][gfraction] = 4, ftext = "~b~Tag Nr.%d resprayed~n~ +15$";
							    case 5: gangtags_info[gtags][gtmodel] = 18665, gangtags_info[gtags][gfraction] = 5, ftext = "~y~Tag Nr.%d resprayed~n~ +15$";
							    case 6: gangtags_info[gtags][gtmodel] = 1528, gangtags_info[gtags][gfraction] = 6, ftext = "~g~~h~~h~Tag Nr.%d resprayed~n~ +15$";
							    case 7: gangtags_info[gtags][gtmodel] = 18667, gangtags_info[gtags][gfraction] = 7, ftext = "~p~Tag Nr.%d resprayed~n~ +15$";
							    case 8: gangtags_info[gtags][gtmodel] = 18664, gangtags_info[gtags][gfraction] = 8, ftext = "~p~Tag Nr.%d resprayed~n~ +15$";
							    case 9: gangtags_info[gtags][gtmodel] = 1525, gangtags_info[gtags][gfraction] = 9, ftext = "~p~Tag Nr.%d resprayed~n~ +15$";
							    default: SCMError(playerid, "{Error}");
							}
							new string[60];
							format(string, sizeof(string), ftext, gangtags_info[gtags][gtid]);
							GameTextForPlayer(playerid, string, 3000, 6);
							DestroyObject(gangtags_info[gtags][gtCreate]);
							gangtags_info[gtags][gtCreate] = CreateObject(gangtags_info[gtags][gtmodel], gangtags_info[gtags][gtCoords1], gangtags_info[gtags][gtCoords2], gangtags_info[gtags][gtCoords3], gangtags_info[gtags][gtCoords4], gangtags_info[gtags][gtCoords5], gangtags_info[gtags][gtCoords6]);
				    	}
				    	save_gangtags(gtags);
				    	/*player_info[playerid][MONEY] += 15;
				    	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
						new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
						mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
						mysql_query(dbHandle, query);*/
					}
	            }
	            else
	            {
	            	SPD(playerid, -1, 0, " ", " ", " ", "");
				}
	        }
	        case DLG_GGPS:
	        {
	            new Float:fDistance;
	            new string[60];
	            if(response)
	            {
	                switch(listitem)
	                {
	                    case 0:
	                    {
	                        fDistance = GetPlayerDistanceFromPoint(playerid, 2529.1592, -1463.8031, 23.9406);
							SetPlayerCheckpoint(playerid, 2529.1592, -1463.8031, 23.9406, 4.0);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 1:
						{
                            fDistance = GetPlayerDistanceFromPoint(playerid, 2445.3489, -1975.7620, 13.5469);
							SetPlayerCheckpoint(playerid, 2445.3489, -1975.7620, 13.5469, 4.0);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
							
						}
	                }
	            }
	            else SPD(playerid, -1, 0, " ", " ", " ", "");
	        }
	        case DLG_GPSNOOBS:
	        {
	            new Float:fDistance;
	            new string[60];
	            if(response)
	            {
	                switch(listitem)
	                {
	                    case 0:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cGR"}Grove Street Families",
							!"{"#cGR"}The Grove Street Families {FFFFFF}(a.k.a {"#cGR"}'Families'{FFFFFF} or {"#cGR"}'GSF'{FFFFFF}, {"#cGR"}'The Grove'{FFFFFF}, or {"#cGR"}'Groves'{FFFFFF})\n\
							{"#cGR"}The Grove Street Families {FFFFFF}is an African-American street gang and one of the oldest street gangs in Los Santos, San Andreas.\n\
							Most of their territory can be found in the poorer/run-down neighborhoods in the far east of the city,\n\
							though they also have small pockets of territory elsewhere",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 2465.9758, -1659.9137, 13.2753, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cGR"}[The Grove Street Families] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 2465.9758, -1659.9137, 13.2753);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 1:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cPINK"}Front Yard Ballas",
							!"{"#cPINK"}The Front Yard Ballas{FFFFFF} are the largest and most powerful of the four sets of {"#cPINK"}Ballas\n\
							The Front Yard Ballas{FFFFFF} control the districts of Idlewood and southern East Los Santos, Los Santos.\n\
							Since Idlewood was originally under {"#cGR"}Grove Street Families{FFFFFF} control,\n\
							it is unlikey they were the original Ballas set, but rose to prominence after taking Idlewood\n\
							from the {"#cGR"}Grove Street Families{FFFFFF} during the early to mid 1980s",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 2450.6035, -1272.0643, 23.8207, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cPINK"}[The Front Yard Ballas] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 2450.6035, -1272.0643, 23.8207);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 2:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cLIGHTBLUE"}Varrios Los Aztecas",
							!"{"#cLIGHTBLUE"}The Varrios Los Aztecas{FFFFFF} (a.k.a. {"#cLIGHTBLUE"}'Aztecas'{FFFFFF}, {"#cLIGHTBLUE"}'Southerners'{FFFFFF}, {"#cLIGHTBLUE"}'Southside Aztecas'{FFFFFF}, or {"#cLIGHTBLUE"}'VLA'{FFFFFF})\n\
							Extremely dangerous hispanic street gang. Violent. Proud. Psychotic.\n\
							Heavily involved in gun running, street violence. Have traditionally been anti-narcotics.\n\
							Much of their origins and past history is unknown.\n\
							It is highly likely that they evolved from the El Corona neighborhood",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 1880.8967, -2051.9956, 13.3828, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cLIGHTBLUE"}[The Varrios Los Aztecas] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 1880.8967, -2051.9956, 13.3828);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 3:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cBLUE"}San Fierro Rifa",
							!"{"#cBLUE"}The San Fierro Rifa{FFFFFF} (or {"#cBLUE"}Rifa{FFFFFF}) is the sole Mexican gang\n\
							They are the least threatening and violent on the streets",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, -2602.6514, -143.4118, 4.1797, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cBLUE"}[The San Fierro Rifa] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, -2602.6514, -143.4118, 4.1797);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*70);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
						case 4:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cYELLOW"}Los Santos Vagos",
							!"{"#cYELLOW"}The Los Santos Vagos{FFFFFF} (a.k.a {"#cYELLOW"}Northside Vagos{FFFFFF}, {"#cYELLOW"}Northerners{FFFFFF}, {"#cYELLOW"}LSV{FFFFFF}, or just the{"#cYELLOW"} Vagos{FFFFFF})\n\
							The history of the {"#cYELLOW"}Vagos{FFFFFF} is shrouded in mystery, as well as many of the events surrounding the gang,\n\
						 	though they probably started forming simultaneously\n\
						 	in relation to the other Los Santos gangs during the 1970s and 1980s.",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 2737.8420, -1191.1868, 69.2422, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cYELLOW"}[The Los Santos Vagos] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 2737.8420, -1191.1868, 69.2422);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 5:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cLIGHTGREEN"}Seville B.L.V.D Families",
							!"{"#cLIGHTGREEN"}The Seville Boulevard Families{FFFFFF} are one of the three sets of the {"#cGR"}Grove Street Families{FFFFFF} gang.\n\
							{"#cLIGHTGREEN"}The Seville Boulevard Families{FFFFFF} are based in the district of Playa del Seville.\n\
							They split allegiance with the {"#cGR"}Grove Street Families{FFFFFF} and Temple Drive Families sometime between 1987 and 1991",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 2768.9399, -1902.6664, 11.1124, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cLIGHTGREEN"}[The Seville Boulevard Families] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 2768.9399, -1902.6664, 11.1124);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 6:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cPINK"}Rollin Heightz Ballas",
							!"{"#cPINK"}The Rollin Heightz Ballas{FFFFFF} are one of the four sets of {"#cPINK"}Ballas\n\
							The Rollin' Heights Ballas{FFFFFF} are based in Jefferson, and also control eastern Willowfield and northern East Los Santos.\n\
							They were one of the original sets of {"#cPINK"}Ballas{FFFFFF}.\n\
							The {"#cPINK"}RHB{FFFFFF} is the second-largest {"#cPINK"}Ballas{FFFFFF} set, behind the {"#cPINK"}Front Yard Ballas.",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 913.3099, -1655.1755, 13.3828, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cPINK"}[The Rollin Heightz Ballas] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 913.3099, -1655.1755, 13.3828);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 7:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cPINK"}Temple Drive Ballas",
							!"{"#cPINK"}Temple Drive Ballas{FFFFFF} are one of the four sets of {"#cPINK"}Ballas{FFFFFF}\n\
							In 1991, the {"#cPINK"}Ballas{FFFFFF} used to control the area of Temple\n\
							Which was under control of the Temple Drive Families prior to 1991.\n\
							{"#cPINK"}Temple Drive Ballas{FFFFFF} become active again after the {"#cGR"}Grove Street Families{FFFFFF}\n\
							are weakened and took back their former territory of Temple from the Temple Drive Families.",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 1162.6483, -1086.5137, 26.0249, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cPINK"}[Temple Drive Ballas] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 1162.6483, -1086.5137, 26.0249);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                    case 8:
	                    {
	                        SPD(playerid, DLG_GANGNOOBINFO, DIALOG_STYLE_MSGBOX, !"{"#cPINK"}Kilo Tray Ballas",
							!"{"#cPINK"}The Kilo Tray Ballas{FFFFFF} are one of the four sets of {"#cPINK"}Ballas{FFFFFF}\n\
							{"#cPINK"}The Kilo Tray Ballas{FFFFFF} are based in Glen Park, and also control the western part of Willowfield.\n\
							They were one of the original sets of {"#cPINK"}Ballas{FFFFFF}.\n\
							However, they are not as powerful as other sets, specifically the {"#cPINK"}Front Yard{FFFFFF} and {"#cPINK"}Rollin' Heights sets.",
							!"Close", !"");
							SetPlayerCheckpoint(playerid, 2006.8604, -1135.5236, 25.1372, 4.0);
							SCM(playerid, COLOR_LIGHTBLUE, "{"#cPINK"}[The Kilo Tray Ballas] {FFFFFF}Marker was placed on your minimap.");
							PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
							fDistance = GetPlayerDistanceFromPoint(playerid, 2006.8604, -1135.5236, 25.1372);
							format(string, sizeof(string), "You are %0.2f meters away from destination", fDistance*10);
							SCM(playerid, COLOR_LIGHTBLUE, string);
	                    }
	                }
	            }
	        }
	        case DLG_FRACCARCHOOSE:
	        {
	            if(response)
	            {
	                SPD(playerid, DLG_FRACCARID, DIALOG_STYLE_LIST, !"Black Market Car Shop",
					!"Sadler Shit\t{"#cBL"}[420$]{FFFFFF}\nBurrito\t\t{"#cBL"}[740$]{FFFFFF}\nOceanic\t{"#cBL"}[940$]{FFFFFF}\nPremier\t{"#cBL"}[1330$]{FFFFFF}\nAdmiral\t\t{"#cBL"}[1730$]{FFFFFF}\nSabre\t\t{"#cBL"}[1940$]{FFFFFF}\nSlamvan\t{"#cBL"}[2220$]{FFFFFF}\nEsperanto\t{"#cBL"}[2600$]{FFFFFF}\n\
					Solair\t[2740$]\nGreenwood\t[3220$]\nVoodoo\t[3600$]\nRemington\t[3940$]\nTahoma\t[4660$]\nBanshee\t[5330$]\nBuffalo\t[6600$]\nSultan\t[7220$]",
					 !"Choose", !"Exit");
	            }
	            else
	            {
	            	SPD(playerid, -1, 0, " ", " ", " ", "");
				}
	        }
	        case DLG_FRACCARID:
	        {
	            if(response)
	            {
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					{
					    return SCMError(playerid, "You must be in fraction car which u want to change");
					}
	                switch(listitem)
	                {
	                    case 0:
	                    {
	                        if(player_info[playerid][MONEY] < 420) // Sadler Shit
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 605;
                            player_info[playerid][MONEY] -= 420;
                            /*save_fraccar(GetPlayerVehicleID(playerid));
             				DestroyVehicle(GetPlayerVehicleID(playerid));
							fraccar_info[GetPlayerVehicleID(playerid)][cCreate] = CreateVehicle(fraccar_info[GetPlayerVehicleID(playerid)][idc], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSX], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSY], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSZ], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARANGLE], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARCOLOR1], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARCOLOR2], 15, 0);
                			SetVehicleToRespawn(GetPlayerVehicleID(playerid));*/
	                    }
	                    case 1:
	                    {
	                        if(player_info[playerid][MONEY] < 740) // Burrito
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 482;
                            player_info[playerid][MONEY] -= 740;
	                    }
	                    case 2:
	                    {
	                        if(player_info[playerid][MONEY] < 940) // Oceanic
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 467;
                            player_info[playerid][MONEY] -= 940;
	                    }
	                    case 3:
	                    {
	                        if(player_info[playerid][MONEY] < 1330)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 426; // Premier
                            player_info[playerid][MONEY] -= 1330;
	                    }
	                    case 4:
	                    {
	                        if(player_info[playerid][MONEY] < 1730)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 445; // Admiral
                            player_info[playerid][MONEY] -= 1730;
	                    }
	                    case 5:
	                    {
	                        if(player_info[playerid][MONEY] < 1940)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 475; // Sabre
                            player_info[playerid][MONEY] -= 1940;
	                    }
	                    case 6:
	                    {
	                        if(player_info[playerid][MONEY] < 2220)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 535; // Slamvan
                            player_info[playerid][MONEY] -= 2220;
	                    }
	                    case 7:
	                    {
	                        if(player_info[playerid][MONEY] < 2600)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 419; // Esperanto
                            player_info[playerid][MONEY] -= 2600;
	                    }
	                    case 8:
	                    {
	                        if(player_info[playerid][MONEY] < 2740)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 458; // Solair
                            player_info[playerid][MONEY] -= 2740;
	                    }
	                    case 9:
	                    {
	                        if(player_info[playerid][MONEY] < 3220)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 492; // Greenwood
                            player_info[playerid][MONEY] -= 3220;
                        }
                        case 10:
	                    {
	                        if(player_info[playerid][MONEY] < 3600)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 412; // Voodoo
                            player_info[playerid][MONEY] -= 3600;
	                    }
	                    case 11:
	                    {
	                        if(player_info[playerid][MONEY] < 3940)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 534; // Remington
                            player_info[playerid][MONEY] -= 3940;
	                    }
	                    case 12:
	                    {
	                        if(player_info[playerid][MONEY] < 4660)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 566; // Tahoma
                            player_info[playerid][MONEY] -= 4660;
	                    }
	                    case 13:
	                    {
	                        if(player_info[playerid][MONEY] < 5330)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 429; // Banshee
                            player_info[playerid][MONEY] -= 5330;
	                    }
	                    case 14:
	                    {
	                        if(player_info[playerid][MONEY] < 6600)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 402; // Buffalo
                            player_info[playerid][MONEY] -= 6600;
	                    }
	                    case 15:
	                    {
	                        if(player_info[playerid][MONEY] < 7220)
	                        {
	                            return SCMError(playerid, "You dont have such money");
	                        }
                            fraccar_info[GetPlayerVehicleID(playerid)][idc] = 560; // Sultan
                            player_info[playerid][MONEY] -= 7220;
	                    }
	                }
	                save_fraccar(GetPlayerVehicleID(playerid));
     				DestroyVehicle(GetPlayerVehicleID(playerid));
					fraccar_info[GetPlayerVehicleID(playerid)][cCreate] = CreateVehicle(fraccar_info[GetPlayerVehicleID(playerid)][idc], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSX], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSY], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARPOSZ], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARANGLE], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARCOLOR1], fraccar_info[GetPlayerVehicleID(playerid)][FRACCARCOLOR2], 15, 0);
        			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	                static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
					new query[sizeof(fmt_query)+(-2+9)+(-2+11)];
					format(query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
					mysql_query(dbHandle, query);
	            }
	        }
	        case DLG_VOPROS:
	        {
	            if(response)
	            {
	                if(!strlen(inputtext))
	                {
	                    SCM(playerid, RED_COLOR, "Type something!");
	                    SPD(playerid, DLG_VOPROS, DIALOG_STYLE_INPUT, !"Type your question", !"", !"Send", !"Back");
	                }
	                if(strlen(inputtext) > 97)
					{
					    SPD(playerid, DLG_VOPROS, DIALOG_STYLE_INPUT, !"Type your question", !"", !"Send", !"Back");
					    return SCMError(playerid, !"Error: too long message");
					}
					static const fmt_query[] = "SELECT * FROM `answers` WHERE `aquestion` = '%s'";
					new query[sizeof(fmt_query)+(-2+97)];
					format(query, sizeof(query), fmt_query, inputtext);
					mysql_tquery(dbHandle, query, "CheckAnswer", "is", playerid, inputtext);
	            }
	            else SPD(playerid, DLG_REPORT, DIALOG_STYLE_LIST, !"InformAdmin", !"Question/Report", !"Send", !"Close");
	        }
	        case DLG_JALOBA:
	        {
	            if(response)
	            {
	                if(!strlen(inputtext))
	                {
	                    SCM(playerid, RED_COLOR, "Type something!");
	                    SPD(playerid, DLG_JALOBA, DIALOG_STYLE_INPUT, !"Type your Report", !"", !"Send", !"Back");
	                }
	                if(strlen(inputtext) > 97)
					{
					    SPD(playerid, DLG_JALOBA, DIALOG_STYLE_INPUT, !"Type your Report", !"", !"Send", !"Back");
					    return SCMError(playerid, !"Error: too long message");
					}
					new string[144];
					format(string, sizeof(string), "Report delivered to administration: %s", inputtext);
					SCM(playerid, WHITE_COLOR, string);
					if(player_info[playerid][ADMIN] > 1)
					{
					format(string, sizeof(string), "[Report] %s[%d]: %s", player_info[playerid][NAME], playerid, inputtext);
					SCMA(RED_COLOR, string);
					}
	            }
	            else SPD(playerid, DLG_REPORT, DIALOG_STYLE_LIST, !"InformAdmin", !"Question/Report", !"Send", !"Close");
	        }
	        case DLG_ANSWERPLAYER:
	        {
	            new questionfrom = GetPVarInt(playerid, "questionfrom");
	            if(response)
	            {
	                if(!strlen(inputtext) || strlen(inputtext) > 60)
	                {
	                    new dialog[45+(-2+MAX_PLAYER_NAME)+(-2+3)+(-2+97)];
						format(dialog, sizeof(dialog), "Question from %s[%d]:\n %s", player_info[questionfrom][NAME], questionfrom, player_info[questionfrom][QUESTION]);
						SetPVarInt(playerid, "questionfrom", questionfrom);
						SPD(playerid, DLG_ANSWERPLAYER, DIALOG_STYLE_INPUT, !"Answer on question", dialog, !"Send" , !"Exit");
						if(strlen(inputtext) > 60) return SCMError(playerid, !"Error: too long message");
						return 1;
	                }
	                new string[144];
	                format(string, sizeof(string), "Administrator %s answer: {FFFFFF} %s",player_info[playerid][NAME], inputtext);
	                SCM(playerid, GREEN_COLOR, string);
	                format(string, sizeof(string), "[Answer] %s answered %s[%d] : {FFFFFF} %s", player_info[playerid][NAME], player_info[questionfrom][NAME], questionfrom, inputtext);
					SCMA(GREEN_COLOR, string);
					if(player_info[playerid][ADMIN] >= 2)
					{
					    SetPVarString(playerid, "fastanswer", inputtext);
					    SPD(playerid, DLG_ADDFASTANSWER, DIALOG_STYLE_MSGBOX, !"Fast Answer", !"Print fast answer", !"Save", !"Exit");
					}
					else
					{
					    DeletePVar(playerid, "questionfrom");
	                	player_info[questionfrom][QUESTION] = EOS;
					}
				}
	            else
	            {
	                new string[144];
	                format(string, sizeof(string), "Administrator %s did not answer on your question", player_info[playerid][NAME]);
	                SCM(questionfrom, RED_COLOR, string);
	                format(string, sizeof(string), "Administrator %s did not answer player %s[%d] on question", player_info[playerid][NAME], player_info[questionfrom][NAME], questionfrom);
	                SCMA(RED_COLOR, string);
	                DeletePVar(playerid, "questionfrom");
	                player_info[questionfrom][QUESTION] = EOS;
	            }
	        }
	        case DLG_ADDFASTANSWER:
	        {
	            if(response)
	            {
	                new questionfrom = GetPVarInt(playerid, "questionfrom");
	                new answerinio[61];
               	 	GetPVarString(playerid, "fastanswer", answerinio, sizeof(answerinio));
               	 	FixSVarString(answerinio);
	                static const fmt_query[] = "INSERT INTO `answers` (`aquestion`, `aanswer`, `aadd`) VALUES ('%s', '%s', '%d')";
					new query[sizeof(fmt_query)+(2+97)+(-2+60)+(-2+8)];
					format(query, sizeof(query), fmt_query, player_info[playerid][QUESTION], answerinio, player_info[playerid][ID]);
					mysql_query(dbHandle, query, false);
					DeletePVar(playerid, "questionfrom");
	                player_info[questionfrom][QUESTION] = EOS;
	                DeletePVar(playerid, "fastanswer");
	            }
	        }
	        case DLG_CAPTURE:
			{
			if(response)
			{
				new faction = player_info[playerid][FRACTION];
				for(new i; i < MAX_GANGZONE; i++)
				{
					if(PlayerToKvadrat(playerid, GZMZ[i][gCoords1], GZMZ[i][gCoords2], GZMZ[i][gCoords3], GZMZ[i][gCoords4]) && ZoneOnBattle[i] == 0)
					{
						if(GZMZ[i][gFrak] == faction) return SendClientMessage(playerid, COLOR_GREY, "Вы не можете захватывать зону вашей банды!");
						if(IsPlayerInBandOnline(faction) < 0) return SCM(playerid,COLOR_GREY, "В вашей банде мало игроков онлайн!");
						if(IsPlayerInBandOnline(GZMZ[i][gFrak]) < 0) return SCM(playerid,COLOR_GREY, "У банды мало игроков!");
						if(IsCapture == 1) return SendClientMessage(playerid, COLOR_GREY, "Уже происходит захват одной из зон. Дождитесь окончания!");
						GangZoneFlashForAll(GZMZ[i][gCreate],GetGZColorF(faction));
						gangstartid = playerid;
						captureID = i;
						GZSafeTime[i] = 60;
						FrakCD  = 3600;
						GZMZ[i][gNapad] = faction;
						ZoneOnBattle[i] = 1;
						IsCapture = 1;
						zGangTime[faction]--;
						GangInfo[faction][capture] = 1;
						GangInfo[GZMZ[i][gFrak]][capture] = 1;
						GangInfo[GZMZ[i][gFrak]][captureid] = faction;
						GangInfo[faction][captureid] = faction;
						GangInfo[faction][gangnumber] = 1;
						GangInfo[GZMZ[i][gFrak]][gangnumber] = 0;
						CaptureStart(faction, GZMZ[i][gFrak]);
						return 1;
					}
				}
			}
			else SendClientMessage(playerid, COLOR_YELLOW, "Вы отменили захват");
			return 1;
		}
	        
	}
	return 1;
}
stock IsACop(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = player_info[playerid][LFRACTION], member = player_info[playerid][FRACTION];
		if(member==13 || member==14 || member==15) return 1;
		if(leader==13 || leader==14 || leader==15) return 1;
	}
	return 0;
}
stock IsAArmy(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = player_info[playerid][LFRACTION], member = player_info[playerid][FRACTION];
		if(member==16 || member==17 || member==18) return 1;
		if(leader==16 || leader==17 || leader==18) return 1;
	}
	return 0;
}
stock IsAGovern(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = player_info[playerid][LFRACTION], member = player_info[playerid][FRACTION];
		if(member==19 || member==20 || member==21) return 1;
		if(leader==19 || leader==20 || leader==21) return 1;
	}
	return 0;
}
stock IsAMafia(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = player_info[playerid][LFRACTION], member = player_info[playerid][FRACTION];
		if(member==10 || member==11 || member==12) return 1;
		if(leader==10 || leader==11 || leader==12) return 1;
	}
	return 0;
}
stock IsAGang(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new leader = player_info[playerid][LFRACTION], member = player_info[playerid][FRACTION];
		if(member==1 || member==2 || member==3 || member==4 || member==5 || member==6 || member==7 || member==8 || member==9) return 1;
		if(leader==1 || leader==2 || leader==3 || leader==4 || leader==5 || leader==6 || leader==7 || leader==8 || leader==9) return 1;
	}
	return 0;
}
stock IsALeader(playerid)
{

	new leader = player_info[playerid][LFRACTION];
	if(leader==1 || leader==2 || leader==3 || leader==4 || leader==5 || leader==6 || leader==7 || leader==8) return 1;
	return 0;
}
forward NarkoTimer(playerid);
public NarkoTimer(playerid)
{
	SetPlayerWeather(playerid, 1);
 	usedrugsbuff[playerid] = 0;
	return 1;
}
/*forward HospitalTimer(playerid);
public HospitalTimer(playerid)
{
    Hospitalized[playerid] = 0;
	SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
	if(player_info[playerid][MONEY] > 14)
	{
		player_info[playerid][MONEY] -= 15;
		SetPlayerHealth(playerid, 100.0);
		SCM(playerid, COLOR_LIGHTBLUE, "You have fully recovered at the hospital for 15$ tax.");
	}
	else
	{
	    SetPlayerHealth(playerid, 50.0);
        SCM(playerid, COLOR_LIGHTBLUE, "You have half-recovered at the hospital, because u did not have enough money to pay.");
	}
	KillTimer(hospitaltimer);
	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
}*/
forward CheckAnswer(playerid, answer[]);
public CheckAnswer(playerid, answer[])
{
	new rows;
	new string[144];
	cache_get_row_count(rows);
	if(rows)
	{
	    new answerek[60], admadd;
	    cache_get_value_name(0, "aanswer", answerek, 60);
	    cache_get_value_name_int(0, "aadd", admadd);
		format(string, sizeof(string), "System has answered: {FFFFFF} %s", answerek);
		SCM(playerid, GREEN_COLOR, string);
		format(string, sizeof(string), "[Answer] System answered to %s[%d] : {FFFFFF} %s", player_info[playerid][NAME], playerid, answerek);
		SCMA(GREEN_COLOR, string);
	}
	else
	{
		format(string, sizeof(string), "Question delivered to administration: %s", answer);
		SCM(playerid, WHITE_COLOR, string);
		format(string, sizeof(string), "[Question] %s[%d]: %s", player_info[playerid][NAME], playerid, answer);
		SCMA(RED_COLOR, string);
		strmid(player_info[playerid][QUESTION], answer, 0, strlen(answer), 97);
		Iter_Add(Question_ITER, playerid);
	}
	return 1;
}
forward OnPlayerAmmoChange(playerid, newammo, oldammo);
public OnPlayerAmmoChange(playerid, newammo, oldammo)
{
	if(newammo < oldammo)
	{
		switch(GetPlayerWeapon(playerid))
		{
		case 24:
			{
				SetPVarInt(playerid, "SkillD", GetPVarInt(playerid, "SkillD") +1);
				if(GetPVarInt(playerid, "SkillD") >= AMMO_DEAGLE && player_info[playerid][GUNSKILL][1] < 100)
				{
					player_info[playerid][GUNSKILL][1]++;
					SetPVarInt(playerid, "SkillD",0);
				}
			}
		case 22:
			{
				SetPVarInt(playerid, "SkillPISTOL", GetPVarInt(playerid, "SkillPISTOL") +1);
				if(GetPVarInt(playerid, "SkillPISTOL")>= AMMO_PISTOL && player_info[playerid][GUNSKILL][0] < 100)
				{
					player_info[playerid][GUNSKILL][0]++;
					SetPVarInt(playerid, "SkillPISTOL",0);
				}
			}
		case 28:
			{
				SetPVarInt(playerid, "SkillShot",GetPVarInt(playerid, "SkillShot") +1);
				if(GetPVarInt(playerid, "SkillShot") >= AMMO_SHOTGUN && player_info[playerid][GUNSKILL][2] < 100)
				{
					player_info[playerid][GUNSKILL][2]++;
					SetPVarInt(playerid, "SkillShot",0);
				}
			}
		case 32:
			{
				SetPVarInt(playerid, "SkillShot",GetPVarInt(playerid, "SkillShot") +1);
				if(GetPVarInt(playerid, "SkillShot") >= AMMO_SHOTGUN && player_info[playerid][GUNSKILL][2] < 100)
				{
					player_info[playerid][GUNSKILL][2]++;
					SetPVarInt(playerid, "SkillShot",0);
				}
			}
		/*case 30:
			{
				SetPVarInt(playerid, "SkillAk47",GetPVarInt(playerid, "SkillAk47") +1);
				if(GetPVarInt(playerid, "SkillAk47") >= AMMO_AK47 && p_t_info[playerid][pGunSkill][4] < 100)
				{
					p_t_info[playerid][pGunSkill][4]++;
					SetPVarInt(playerid, "SkillAk47",0);
				}
			}
		case 31:
			{
				SetPVarInt(playerid, "SkillM4",GetPVarInt(playerid, "SkillM4") +1);
				if(GetPVarInt(playerid, "SkillM4") >= AMMO_M4A1 && p_t_info[playerid][pGunSkill][5] < 100)
				{
					p_t_info[playerid][pGunSkill][5]++;
					SetPVarInt(playerid, "SkillM4",0);
				}
			}*/
		}
	}
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    new Float: health, Float: armour;
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
    /*if(issuerid == INVALID_PLAYER_ID)
    {
        if(usedrugsbuff[playerid] != 0)
        {
            SetPlayerHealth(playerid, health - 1);
        }
    }*/
    switch(weaponid)
    {
        case 31:
        {
            if(usedrugsbuff[playerid] != 0)
            {
                SetPlayerHealth(playerid, health - 3);
            }
            switch(armour)
    		{
		        case 0: 
		        {
		            SetPlayerArmour(playerid, armour - 3);
		        }
		    }
        }
        /*case 31:
        {
            // Codes
        }
        case 34: 
        {
            // Codes
        }*/
    }
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    new Float: health, Float: armour;
    GetPlayerHealth(damagedid, health);
    GetPlayerArmour(damagedid, armour);
    switch(weaponid)
    {
        case 0:
        {
            if(usedrugsbuff[playerid] != 0)
            {
                SetPlayerHealth(damagedid, health - 40);
            }
            switch(armour)
    		{
		        case 0:
		        {
		            SetPlayerArmour(damagedid, armour - 2);
		        }
		    }
        }
    }
	return 1;
}
forward PlayerLogin(playerid);
public PlayerLogin(playerid)
{
	new rows;
	cache_get_row_count(rows);
	new maximum[300];
	if(rows)
	{
	    cache_get_value_name_int(0, "id", player_info[playerid][ID]);
	    cache_get_value_name(0, "email", player_info[playerid][EMAIL], 64);
	    cache_get_value_name_int(0, "race", player_info[playerid][RACE]);
	    cache_get_value_name_int(0, "age", player_info[playerid][AGE]);
	    cache_get_value_name_int(0, "sex", player_info[playerid][SEX]);
	    cache_get_value_name_int(0, "skin", player_info[playerid][SKIN]);
	    cache_get_value_name(0, "regdata", player_info[playerid][REGDATA], 13);
	    cache_get_value_name(0, "regip", player_info[playerid][REGIP], 16);
	    cache_get_value_name_int(0, "admin", player_info[playerid][ADMIN]);
	    cache_get_value_name_int(0, "money", player_info[playerid][MONEY]);
	    cache_get_value_name_int(0, "vozrast", player_info[playerid][VOZRAST]);
	    cache_get_value_name_int(0, "vozrastexp", player_info[playerid][VOZRASTEXP]);
	    cache_get_value_name_int(0, "minutes", player_info[playerid][MINUTES]);
	    cache_get_value_name_int(0, "heroin", player_info[playerid][HEROIN]);
	    cache_get_value_name_int(0, "fraction", player_info[playerid][FRACTION]);
	    cache_get_value_name_int(0, "lfraction", player_info[playerid][LFRACTION]);
	    cache_get_value_name_int(0, "fractionrang", player_info[playerid][FRACTIONRANG]);
	    cache_get_value_name(0, "skills", player_info[playerid][SKILLS], 32);
		if(player_info[playerid][ADMIN] > 0) Iter_Add(Admins_ITER, playerid);
	    sscanf(player_info[playerid][SKILLS], "p<,>a<i>[3]",player_info[playerid][GUNSKILL]);
	    cache_get_value_name(0, "weaponid", maximum), sscanf(maximum,"p<,>a<i>[13]", player_info[playerid][WEAPONID]);
        cache_get_value_name(0, "ammos", maximum), sscanf(maximum,"p<,>a<i>[13]", player_info[playerid][AMMOS]);
		SetPlayerSkills(playerid);
	    SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	    SetPVarInt(playerid, "logged", 1);
	    TogglePlayerSpectating(playerid, 0);
	    SpawnPlayer(playerid);
	    GiveWeapon(playerid);
	}
	return 1;
}
stock SaveWeapon(playerid)
{
        new query[300];
        new saveweap[300];
        new saveammo[300];
        for(new i = 1; i < 13; i++)
        {
            GetPlayerWeaponData(playerid, i, player_info[playerid][WEAPONID][i], player_info[playerid][AMMOS][i]);
            format(saveweap, 300, "%s%d,", saveweap, player_info[playerid][WEAPONID][i]);
            format(saveammo, 300, "%s%d,", saveammo, player_info[playerid][AMMOS][i]);
            format(query,sizeof(query), "UPDATE `users` SET `weaponid` = '%s', `ammos` = '%s' WHERE `id` = '%d'", saveweap, saveammo, player_info[playerid][ID]);
            mysql_tquery(dbHandle, query);
        }
}
/*stock SaveWeapons()
{
        new query[300];
        new saveweap[300];
        new saveammo[300];
        foreach(new playerid:Player)
        {
	        for(new i = 1; i < 13; i++)
	        {
	            GetPlayerWeaponData(playerid, i, player_info[playerid][WEAPONID][i], player_info[playerid][AMMOS][i]);
	            format(saveweap, 300, "%s%d,", saveweap, player_info[playerid][WEAPONID][i]);
	            format(saveammo, 300, "%s%d,", saveammo, player_info[playerid][AMMOS][i]);
	            format(query,sizeof(query), "UPDATE `users` SET `weaponid` = '%s', `ammos` = '%s' WHERE `id` = '%d'", saveweap, saveammo, player_info[playerid][ID]);
	            mysql_tquery(dbHandle, query);
	        }
        }
}*/
stock GiveWeapon(playerid)
{
    for(new i; i < 13; i++)
    {
        GivePlayerWeapon(playerid, player_info[playerid][WEAPONID][i], player_info[playerid][AMMOS][i]);
    }
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(player_info[playerid][ADMIN] >= 4)
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
			SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);
			PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
	    }
	    else
	    {
	        SetPlayerPos(playerid, fX, fY, fZ);
	    }
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	}
	// SetPlayerPosFindZ(playerid, fX, fY, fZ);
	return 1;
}

stock GiveMoney(playerid, money)
{
	player_info[playerid][MONEY] += money;
	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+9)+(-2+11)];
	format(query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
	// GivePlayerMoney(playerid, money);
}

stock VehRepair(vehicleid)
{
	return RepairVehicle(vehicleid);
}
stock ResetVariables(playerid)
{
	inadmcar[playerid] = -1;
}
stock ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	new Float:posx;new Float:posy;new Float:posz;new Float:oldposx;new Float:oldposy;new Float:oldposz;new Float:tempposx;new Float:tempposy;new Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) SCM(i, col1, string);
				else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) SCM(i, col2, string);
				else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) SCM(i, col3, string);
				else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) SCM(i, col4, string);
				else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) SCM(i, col5, string);
			}
		}
	}
	return 1;
}

stock GiveExp(playerid, exp)
{
	player_info[playerid][VOZRASTEXP] += exp;
	new experience = needexp;
	new buffer = player_info[playerid][VOZRASTEXP] - experience;
	if(player_info[playerid][VOZRASTEXP] >= experience)
	{
	    player_info[playerid][VOZRASTEXP] = 0;
	    if(buffer > 0) player_info[playerid][VOZRASTEXP] += buffer;
	    player_info[playerid][VOZRAST]++;
	    player_info[playerid][AGE]++;
	    SCM(playerid, WHITE_COLOR, "Your level has increased!");
	    SetPlayerScore(playerid, player_info[playerid][VOZRAST]);
	}
	static const fmt_query[] = "UPDATE `users` SET `vozrast` = '%d', `vozrastexp` = '%d', `age` = '%d' WHERE `id` = '%d' LIMIT 1";
 	new query[sizeof(fmt_query)+(-2+9)+(-2+8)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][VOZRAST], player_info[playerid][VOZRASTEXP], player_info[playerid][AGE], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
}

stock ShowStats(playerid, checkadm)
{
	new dialog[300];
	new rank = player_info[playerid][FRACTIONRANG];
	new daes = player_info[playerid][MINUTES] / 2;
	format(dialog, sizeof(dialog),
	"{0089ff} Nickname:\t%s\n\
	 {0089ff} Sex:\t\t%s\n\
	 {0089ff} Race:\t\t%s\n\
	 {0089ff} Age:\t\t%d\n\
	 {0089ff} Years lived:\t%d\n\
	 {0089ff} Heroine:\t%d\n\
	 {0089ff} Org:\t\t%s\n\
	 {0089ff} Rank:\t\t%s[%d]\n\
	 {0089ff} Days Lived:\t%d/30\n\
	 {0089ff} Months lived:\t%d/%d", player_info[playerid][NAME], (player_info[playerid][SEX] == 1) ? ("Male") : ("Female"), Races[player_info[playerid][RACE]-1], player_info[playerid][AGE], player_info[playerid][VOZRAST], player_info[playerid][HEROIN],
	  gFractionName[player_info[playerid][FRACTION]], gFractionRankName[player_info[playerid][FRACTION]][rank], player_info[playerid][FRACTIONRANG], daes, player_info[playerid][VOZRASTEXP], needexp);
	if(checkadm == 0) SPD(playerid, DLG_STATS, DIALOG_STYLE_MSGBOX, "Character Stats", dialog, "OK", "Close");
	else SPD(playerid, DLG_NONE, DIALOG_STYLE_MSGBOX, "%s Character Stats", dialog, "", "Close");
	
}

stock SCMA(color, text[])
{
	foreach(new i: Admins_ITER) SCM(i, color, text);
}
stock FixSVarString(str[], size = sizeof(str))
{
	for (new i = 0; ((str[i] &= 0xFF) != '\0') && (++i != size);) {}
}
CMD:drugs(playerid)
{
    if(player_info[playerid][ADMIN] < 3) return 1;
	player_info[playerid][HEROIN]++;
	SCM(playerid, WHITE_COLOR, "You got HEROIN +1");
	static const fmt_query[] = "UPDATE `users` SET `heroin` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+64)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][HEROIN], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:members(playerid, params[])
{
	new want_text[128],want1,sttr[512];
	new rank = player_info[playerid][FRACTIONRANG];
	if(!player_info[playerid][FRACTION]) return SendClientMessage(playerid,CGRAY,"Вы не состоите в организации");
	new fractionid = player_info[playerid][FRACTION];
	format(want_text,sizeof(want_text),"{FFD980}ID\tРанг\t\t\tИмя игрока\n");
	strcat(sttr, want_text);
	foreach(new i : Player)
	{
	    if(player_info[playerid][FRACTION] != fractionid) continue;
     	format(want_text,sizeof(want_text), "{"#cW"}%d\t[%d] %s\t %s\n", i, player_info[playerid][FRACTIONRANG], gFractionRankName[player_info[playerid][FRACTION]][rank], player_info[i][NAME]);
		strcat(sttr, want_text);
		want1++;
	}
	if(want1 == 0) strcat(sttr, "{"#cW"}Информация не найдена");
	SPD(playerid, DLG_MES, 0, "{"#cOR"}Члены организации онлайн", sttr, "Закрыть", "");
	return 1;
}
CMD:spawn(playerid)
{
    TogglePlayerSpectating(playerid, 0);
	SetPVarInt(playerid, "logged", 1);
	SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
}
CMD:showstats(playerid)
{
	ShowStats(playerid, 0);
}
CMD:help(playerid)
{
	SCM(playerid, WHITE_COLOR, "You can also teleport from clicking on map ( 4 lvl admin required )");
	SCM(playerid, WHITE_COLOR, "Commands: /spawn /showstats /report /skill /leaders /admins /id /time /fraccarrespawn /usedrugs");
	SCM(playerid, WHITE_COLOR, "Gangs: /fraccarrespawn /f /fb /checkfracmoney /putmoney /ggps /getmoney");
	SCM(playerid, WHITE_COLOR, "Admin Commands: /drugs /aveh /otvet /aanswer /settime /weather /repairveh /makeadmin /sethp /setskin /kick /setarmour");
    SCM(playerid, WHITE_COLOR, "Admin Commands: /goto /gethere /gzcolor /agun /makeleader /givemoney /uval /setrang /setfraccar /getfraccar");
    SCM(playerid, WHITE_COLOR, "Admin Commands: /repairvehpl /setgangtag");
    SCM(playerid, WHITE_COLOR, "Чекнуть дамаг с броней и под наркотиками");
}
CMD:weather(playerid, params[])
{
	if(player_info[playerid][ADMIN] < 3) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Try /weather [id]");
	if(params[0] < 0 || params[0] > 45) return SCM(playerid, RED_COLOR, !"Weather id must be 0-45");
    SetWeather(params[0]);
	new string[36+(-2+MAX_PLAYER_NAME)+(-2+3)];
	format(string, sizeof(string), "Weather was set by Administrator %s[%d]", player_info[playerid][NAME], playerid);
	SCMA(RED_COLOR, string);
	return 1;
}
CMD:settime(playerid, params[])
{
	if(player_info[playerid][ADMIN] < 3) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Try /settime [0-23]");
	if(params[0] < 0 || params[0] > 23) return SCM(playerid, RED_COLOR, !"Time must be [0-23]");
	SetWorldTime(params[0]);
	new string[36+(-2+MAX_PLAYER_NAME)+(-2+3)];
	format(string, sizeof(string), "Time was set by Administrator %s[%d]", player_info[playerid][NAME], playerid);
	SCMA(RED_COLOR, string);
	return 1;
}
CMD:report(playerid)
{
	SPD(playerid, DLG_REPORT, DIALOG_STYLE_LIST, !"InformAdmin", !"Question\nJalobablyat", !"Send", !"Close");
}
CMD:s(playerid, params[])
{
	if(sscanf(params, "s[105]", params[0])) return SCM(playerid, WHITE_COLOR, !"Type /s [text]");
	new string [144];
	format(string, sizeof(string), "%s[%d] крикнул: %s", player_info[playerid][NAME], playerid, params[0]);
	ProxDetector(30.0, playerid, string, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR, WHITE_COLOR);
 	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
 	{
 	    //ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 0, 0, 0, 0);
 	    ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.1, 0, 0, 0, 0, 0);
 	}
	SetPlayerChatBubble(playerid, params[0], WHITE_COLOR, 25, 7500);
	return 1;
}
CMD:otvet(playerid, params[])
{
	if(player_info[playerid][ADMIN] < 1) return SCM(playerid, WHITE_COLOR, !"You're not an administrator");
	if(sscanf(params, "ds[62]", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Try /otvet [PlayerID] [Text]");
	if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"User is not logged in");
	new string[144];
	format(string, sizeof(string), "Administrator %s answered: {FFFFFF}%s", player_info[playerid][NAME], params[1]);
	SCM(playerid, RED_COLOR, string);
	format(string, sizeof(string), "[Answer] %s for %s[%d]: {FFFFFF}%s", player_info[playerid][NAME], player_info[params[0]][NAME], params[0], params[1]);
	SCM(params[0], RED_COLOR, string);
	return 1;
}
CMD:repairvehpl(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 1) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Type /repairvehpl ID");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(GetPlayerState(params[0]) != PLAYER_STATE_DRIVER) return SCMError(playerid, "Player is not in vehicle");
	if(IsPlayerInAnyVehicle(params[0]))
	{
		VehRepair(GetPlayerVehicleID(params[0]));
		new string[50];
		format(string, sizeof(string), "You have repaired %s vehicle", player_info[params[0]][NAME]);
		SCM(playerid, RED_COLOR, string);
		format(string, sizeof(string), "Administrator %s has repaired your vehicle", player_info[playerid][NAME]);
		SCM(params[0], RED_COLOR, string);
	}
	return 1;
}

CMD:makeadmin(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 3) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /makeadmin ID level");
    if(!(1 <= params[1] <= 7)) return SCM(playerid, RED_COLOR, !"Level must be 1 - 7");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    player_info[params[0]][ADMIN] = params[1];
    new string[100+(-2+MAX_PLAYER_NAME)];
	format(string, sizeof(string), "[Admin] Admin %s gave to %s %d admin level", player_info[playerid][NAME], player_info[params[0]][NAME], params[1]);
	SCMA(RED_COLOR, string);
	format(string, sizeof(string), "[Admin] Admin %s gave you %d admin level", player_info[playerid][NAME], params[1]);
	SCM(params[0], RED_COLOR, string);
	static const fmt_query[] = "UPDATE `users` SET `admin` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][ADMIN], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
    return 1;
}
CMD:makeleader(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 4) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /makeleader ID LeaderID");
    if(!(0 <= params[1] <= 21)) return SCM(playerid, RED_COLOR, !"Leader id must be 0 - 21");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
	player_info[params[0]][LFRACTION] = params[1];
	player_info[params[0]][FRACTION] = params[1];
	SetPlayerColor(params[0],gFractionColor[params[1]]);
	if(params[1] > 0)
		player_info[params[0]][FRACTIONRANG] = 10;
	new string[120+(-2+MAX_PLAYER_NAME)];
	format(string, sizeof(string), "You made %s leader of %s", player_info[params[0]][NAME], gFractionName[params[1]]);
	SCM(playerid, WHITE_COLOR, string);
	format(string, sizeof(string), "Administrator %s made you leader of %s", player_info[playerid][NAME], gFractionName[params[1]]);
	SCM(params[0], WHITE_COLOR, string);
	static const fmt_query[] = "UPDATE `users` SET `lfraction` = '%d', `fraction` = '%d', `fractionrang` = '%d' WHERE `ID` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+8)+(-2+8)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][LFRACTION], player_info[params[0]][FRACTION], player_info[params[0]][FRACTIONRANG], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:goto(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 1) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Type /goto ID");
	if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
	if(params[0] == playerid) return SCM(playerid, RED_COLOR, !"You cant teleport yourself");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(params[0], x, y, z);
	new vw = GetPlayerVirtualWorld(params[0]);
	new inter = GetPlayerInterior(params[0]);
	SetPlayerPos(playerid, x+1.0, y+1.0, z);
	SetPlayerVirtualWorld(playerid, vw);
	SetPlayerInterior(playerid, inter);
	return 1;
}
CMD:gethere(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 1) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Type /gethere ID");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(params[0] == playerid) return SCM(playerid, RED_COLOR, !"You cant teleport yourself");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new vw = GetPlayerVirtualWorld(playerid);
	new inter = GetPlayerInterior(playerid);
	SetPlayerPos(params[0], x+1.0, y+1.0, z);
	SetPlayerVirtualWorld(params[0], vw);
	SetPlayerInterior(params[0], inter);
	new string[47+(-2+MAX_PLAYER_NAME)];
	format(string, sizeof(string), "Administrator %s teleported you", player_info[playerid][NAME]);
	SCM(params[0], WHITE_COLOR, string);
	return 1;
}
CMD:admins(playerid)
{
    if(player_info[playerid][ADMIN] < 1) return 1;
	SCM(playerid, WHITE_COLOR, "Administration on-line:");
	new string[32+(-2+MAX_PLAYER_NAME)+(-2+3)+(-2+1)];
	foreach(new i: Admins_ITER)
	{
	    format(string, sizeof(string), "%s[%d] [%d level]", player_info[i][NAME], i, player_info[i][ADMIN]);
	    if(AFK[i] >= 2)
	    {
	        format(string, sizeof(string), "%s{DA78D6} AFK", string);
	    }
	    SCM(playerid, WHITE_COLOR, string);
	}
    return 1;
}
CMD:aveh(playerid, params[])
{
    new Float:health;
	if(player_info[playerid][ADMIN] < 3) return 1;
	if(sscanf(params, "dddd", params[0], params[1], params[2], params[3])) return SCMError(playerid, !"Type /aveh playerid carid color1 color2");
	if(GetPVarInt(params[0], "logged") == 0) return SCMError(playerid, !"Player is not logged in");
	if(GetPlayerInterior(params[0]) != 0) return SCMError(playerid, !"Player is in interior");
	if(GetPlayerState(params[0]) == PLAYER_STATE_DRIVER) return SCMError(playerid, "Player already in vehicle");
	if(!(400 <= params[1] <= 611)) return SCMError(playerid, !"VehID must be 400 - 611");
	if(!(0 <= params[2] <= 255)) return SCMError(playerid, !"color1 must be 0 - 255");
	if(!(0 <= params[3] <= 255)) return SCMError(playerid, !"color2 must be 0 - 255");
	GetPlayerHealth(playerid, health);
	if(health <= 0) return SCMError(playerid, "You cant spawn vehicles while you're dead");
	if(AFK[params[0]] > 0) return SCMError(playerid, "Player is AFK");
	new Float:x, Float:y, Float:z, Float:Angle;
	GetPlayerFacingAngle(playerid, Angle);
	GetPlayerPos(params[0], x, y, z);
	inadmcar[params[0]] = CreateVehicle(params[1], x, y, z, Angle, params[2], params[3], -1);
	PutPlayerInVehicle(params[0], inadmcar[params[0]] ,0);
	return 1;
}
CMD:repairveh(playerid)
{
    if(player_info[playerid][ADMIN] < 1) return 1;
	if(IsPlayerInAnyVehicle(playerid))
	{
		VehRepair(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, WHITE_COLOR, "Car repaired");
	}
	return 1;
}

CMD:aanswer(playerid, params[])
{
	if(player_info[playerid][ADMIN] < 1) return 1;
	if(Iter_Count(Question_ITER) == 0) return SCM(playerid, RED_COLOR, "No questions");
	new questionfrom = Iter_Random(Question_ITER);
	Iter_Remove(Question_ITER, questionfrom);
	new dialog[45+(-2+MAX_PLAYER_NAME)+(-2+3)+(-2+97)];
	format(dialog, sizeof(dialog), "Question from %s[%d]:\n %s", player_info[questionfrom][NAME], questionfrom, player_info[questionfrom][QUESTION]);
	SetPVarInt(playerid, "questionfrom", questionfrom);
	SPD(playerid, DLG_ANSWERPLAYER, DIALOG_STYLE_INPUT, !"Answer on question", dialog, !"Send" , !"Exit");
	return 1;
}

forward LoadGZ();
public LoadGZ()
{
	new rows;
	cache_get_row_count(rows);

    for (new gz; gz < MAX_GANGZONE; gz++)
	{
    	cache_get_value_name_int(gz, "id", GZMZ[gz][idm]);
		cache_get_value_name_float(gz, "ginfo1", GZMZ[gz][gCoords1]);
		cache_get_value_name_float(gz, "ginfo2", GZMZ[gz][gCoords2]);
		cache_get_value_name_float(gz, "ginfo3", GZMZ[gz][gCoords3]);
		cache_get_value_name_float(gz, "ginfo4", GZMZ[gz][gCoords4]);
		cache_get_value_name_int(gz, "fraction", GZMZ[gz][gFrak]);

		GZMZ[gz][gCreate] = GangZoneCreate(GZMZ[gz][gCoords1], GZMZ[gz][gCoords2], GZMZ[gz][gCoords3], GZMZ[gz][gCoords4]);
	}
	return printf("> [MySQL] Loading Gangzone: Loaded - %d", MAX_GANGZONE);
}
forward LoadGTags();
public LoadGTags()
{
	new rows;
	cache_get_row_count(rows);

    for (new gt; gt < MAXGANGTAGS; gt++)
	{
    	cache_get_value_name_int(gt, "id", gangtags_info[gt][gtid]);
    	cache_get_value_name_int(gt, "model", gangtags_info[gt][gtmodel]);
		cache_get_value_name_float(gt, "gtinfo1", gangtags_info[gt][gtCoords1]);
		cache_get_value_name_float(gt, "gtinfo2", gangtags_info[gt][gtCoords2]);
		cache_get_value_name_float(gt, "gtinfo3", gangtags_info[gt][gtCoords3]);
		cache_get_value_name_float(gt, "gtinfo4", gangtags_info[gt][gtCoords4]);
		cache_get_value_name_float(gt, "gtinfo5", gangtags_info[gt][gtCoords5]);
		cache_get_value_name_float(gt, "gtinfo6", gangtags_info[gt][gtCoords6]);
		cache_get_value_name_int(gt, "fraction", gangtags_info[gt][gfraction]);

		gangtags_info[gt][gtCreate] = CreateObject(gangtags_info[gt][gtmodel], gangtags_info[gt][gtCoords1], gangtags_info[gt][gtCoords2], gangtags_info[gt][gtCoords3], gangtags_info[gt][gtCoords4], gangtags_info[gt][gtCoords5], gangtags_info[gt][gtCoords6]);
	}
	return printf("> [MySQL] Loading Tags: Loaded - %d", MAXGANGTAGS);
}
forward LoadFracStore();
public LoadFracStore()
{
	new rows;
	cache_get_row_count(rows);

    for (new stores; stores < gangstore; stores++)
	{
    	cache_get_value_name_int(stores, "fraction", fracstorage[stores][FRACID]);
		cache_get_value_name_int(stores, "money", fracstorage[stores][FRACMONEY]);
		cache_get_value_name_int(stores, "drugs", fracstorage[stores][FRACDRUGS]);
		cache_get_value_name_int(stores, "ammo", fracstorage[stores][FRACAMMO]);
	}
	return printf("> [MySQL] Loading Fraction Stores: Loaded - %d", gangstore);
}
forward LoadFRACCAR();
public LoadFRACCAR()
{
	new rows, x;
	cache_get_row_count(rows);

    for (new cars; cars < MAXFRACCAR; cars++)
	{
	    x = cars + 1;
    	cache_get_value_name_int(cars, "id", fraccar_info[x][idc]);
		cache_get_value_name_int(cars, "color1", fraccar_info[x][FRACCARCOLOR1]);
		cache_get_value_name_int(cars, "color2", fraccar_info[x][FRACCARCOLOR2]);
		cache_get_value_name_float(cars, "posx", fraccar_info[x][FRACCARPOSX]);
		cache_get_value_name_float(cars, "posy", fraccar_info[x][FRACCARPOSY]);
		cache_get_value_name_float(cars, "posz", fraccar_info[x][FRACCARPOSZ]);
		cache_get_value_name_float(cars, "angle", fraccar_info[x][FRACCARANGLE]);
		cache_get_value_name_int(cars, "fraction", fraccar_info[x][FRACCARFRACTION]);
		cache_get_value_name_int(cars, "number", fraccar_info[x][FRACCARNUMBER]);

		fraccar_info[x][cCreate] = AddStaticVehicleEx(fraccar_info[x][idc], fraccar_info[x][FRACCARPOSX], fraccar_info[x][FRACCARPOSY], fraccar_info[x][FRACCARPOSZ], fraccar_info[x][FRACCARANGLE], fraccar_info[x][FRACCARCOLOR1], fraccar_info[x][FRACCARCOLOR2], 15, 0);
	}
	return printf("> [MySQL] Loading Fraction Cars: Loaded - %d", MAXFRACCAR);
}
stock save_fraccar(cid)
{
	new query[512];
	format(query, sizeof(query), "UPDATE `fraccar` SET `id` = '%d', `number` = '%d' WHERE `fraction` = '%d'",
	fraccar_info[cid][idc], fraccar_info[cid][FRACCARNUMBER], fraccar_info[cid][FRACCARFRACTION]);
	mysql_tquery(dbHandle, query);
	return 1;
}
stock save_gangtags(gtsid)
{
	new query[512];
	format(query, sizeof(query), "UPDATE `gangtags` SET `model` = '%d', `fraction` = '%d' WHERE `id` = '%d'",
	gangtags_info[gtsid][gtmodel], gangtags_info[gtsid][gfraction], gangtags_info[gtsid][gtid]);
	mysql_tquery(dbHandle, query);
}
CMD:getfraccar(playerid)
{
    if(player_info[playerid][ADMIN] < 7) return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCMError(playerid, "You must be in a car");
    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] < 1) return SCMError(playerid, "This is not a fraction car");
	new string[40];
	format(string, sizeof(string), "Car ID(IDNumber): {"#cBL"}%d", fraccar_info[GetPlayerVehicleID(playerid)][FRACCARFRACTION]);
	SCM(playerid, WHITE_COLOR, string);
	return 1;
}
stock save_fracstores(fsid)
{
	new query[512];
	format(query, sizeof(query), "UPDATE `fracstore` SET `money` = '%d', `drugs` = '%d', `ammo` = '%d' WHERE `fraction` = '%d'",
	fracstorage[fsid][FRACMONEY], fracstorage[fsid][FRACDRUGS], fracstorage[fsid][FRACAMMO], fracstorage[fsid][FRACID]);
	mysql_tquery(dbHandle, query);
	return 1;
}
CMD:fracpayday(playerid)
{
	if(player_info[playerid][ADMIN] < 1) return SCMError(playerid, "Error");
	FracPayDay();
	return 1;
}
CMD:putmoney(playerid, params[])
{
	if(player_info[playerid][FRACTION] < 1) return SCMError(playerid, "Error");
	if(sscanf(params, "d", params[0])) return SCMError(playerid, "Type /putmoney [count]");
	if(params[0] > player_info[playerid][MONEY]) return SCMError(playerid, "You dont have such money");
	for (new stores; stores < gangstore; stores++)
	{
	    if(fracstorage[stores][FRACID] == player_info[playerid][FRACTION]) fracstorage[stores][FRACMONEY] += params[0], player_info[playerid][MONEY] -= params[0];
	    save_fracstores(stores);
	}
	new string[25];
	format(string, sizeof(string), "Fraction money +%d", params[0]);
	SCM(playerid, COLOR_LIGHTBLUE, string);
	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:getmoney(playerid, params[])
{
    if(player_info[playerid][FRACTION] < 1) return SCMError(playerid, "Error");
	if(sscanf(params, "d", params[0])) return SCMError(playerid, "Type /getmoney [count]");
	for (new stores; stores < gangstore; stores++)
	{
	    if(fracstorage[stores][FRACMONEY] < params[0] || params[0] < 0) return SCMError(playerid, "Your gang store dont have such money");
	    if(fracstorage[stores][FRACID] == player_info[playerid][FRACTION]) fracstorage[stores][FRACMONEY] -= params[0], player_info[playerid][MONEY] += params[0];
	    save_fracstores(stores);
	}
	new string[25];
	format(string, sizeof(string), "You took %d$", params[0]);
	SCM(playerid, COLOR_LIGHTBLUE, string);
	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][MONEY], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:checkfracmoney(playerid)
{
	new string[60];
	if(player_info[playerid][FRACTION] < 1) return SCMError(playerid, "Error");
	for (new stores; stores < gangstore; stores++)
	{
	    if(fracstorage[stores][FRACID] == player_info[playerid][FRACTION])
	    {
			format(string, sizeof(string), "Your fraction store have: %d money, %d drugs, %d ammo", fracstorage[stores][FRACMONEY], fracstorage[stores][FRACDRUGS], fracstorage[stores][FRACAMMO]);
			SCM(playerid, COLOR_LIGHTBLUE, string);
	    }
	    save_fracstores(stores);
	}
	return 1;
}
CMD:setgangtag(playerid, params[])
{
	new x;
    if(player_info[playerid][ADMIN] < 7) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Type /setgangtag IDfraction");
    if(!(1 <= params[0] <= 9)) return SCM(playerid, RED_COLOR, !"IDFraction must be 1 - 9");
    for(new gtags; gtags < MAXGANGTAGS; gtags++)
	{
	    x = gtags;
	    if(IsPlayerInRangeOfPoint(playerid, 2.0, gangtags_info[x][gtCoords1], gangtags_info[x][gtCoords2], gangtags_info[x][gtCoords3]))
	    {
			switch(params[0])
			{
			    case 1: gangtags_info[x][gtmodel] = 18659, gangtags_info[x][gfraction] = 1;
			    case 2: gangtags_info[x][gtmodel] = 18666, gangtags_info[x][gfraction] = 2;
				case 3: gangtags_info[x][gtmodel] = 1531, gangtags_info[x][gfraction] = 3;
			    case 4: gangtags_info[x][gtmodel] = 18663, gangtags_info[x][gfraction] = 4;
			    case 5: gangtags_info[x][gtmodel] = 18665, gangtags_info[x][gfraction] = 5;
			    case 6: gangtags_info[x][gtmodel] = 1528, gangtags_info[x][gfraction] = 6;
			    case 7: gangtags_info[x][gtmodel] = 18667, gangtags_info[x][gfraction] = 7;
			    case 8: gangtags_info[x][gtmodel] = 18664, gangtags_info[x][gfraction] = 8;
			    case 9: gangtags_info[x][gtmodel] = 1525, gangtags_info[x][gfraction] = 9;
			}
			new string[21];
			format(string, sizeof(string), "Tag Nr. %d Recreated", gangtags_info[x][gtid]);
			SCM(playerid, COLOR_LIGHTBLUE, string);
			DestroyObject(gangtags_info[x][gtCreate]);
			gangtags_info[x][gtCreate] = CreateObject(gangtags_info[x][gtmodel], gangtags_info[x][gtCoords1], gangtags_info[x][gtCoords2], gangtags_info[x][gtCoords3], gangtags_info[x][gtCoords4], gangtags_info[x][gtCoords5], gangtags_info[x][gtCoords6]);
    	}
    	save_gangtags(x);
	}
	return 1;
}
CMD:setfraccar(playerid, params[])
{
	new x;
    if(player_info[playerid][ADMIN] < 7) return 1;
    if(sscanf(params, "ddd", params[0], params[1], params[2])) return SCM(playerid, RED_COLOR, !"Type /setfraccar IDNumber IDCar IDFraction");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCMError(playerid, "You must be in a car which u want to change");
    if(!(0 <= params[0] <= 1000)) return SCM(playerid, RED_COLOR, !"IDNumber must be 0-4, 1000");
    if(!(400 <= params[1] <= 611)) return SCM(playerid, RED_COLOR, !"IDCar must be 400 - 611");
    if(!(1 <= params[2] <= 9)) return SCM(playerid, RED_COLOR, !"IDFraction must be 1 - 9");
    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARFRACTION] != params[0]) return SCMError(playerid, "You are not in vehicle or wrong car for IDNumber");
    if(fraccar_info[GetPlayerVehicleID(playerid)][FRACCARFRACTION] == params[0])
    {
        fraccar_info[GetPlayerVehicleID(playerid)][idc] = params[1];
        fraccar_info[GetPlayerVehicleID(playerid)][FRACCARNUMBER] = params[2];
	    new string[60+(-2+MAX_PLAYER_NAME)];
	    format(string, sizeof(string), "You set %d vehicle ID %d number", params[1], params[0]);
		SCM(playerid, RED_COLOR, string);
		save_fraccar(GetPlayerVehicleID(playerid));
		for(new cars; cars < MAXFRACCAR; cars++)
		{
	    	x = cars + 1;
	    	if(fraccar_info[x][FRACCARFRACTION] == params[0])
	    	{
                DestroyVehicle(GetPlayerVehicleID(playerid));
				fraccar_info[x][cCreate] = CreateVehicle(fraccar_info[x][idc], fraccar_info[x][FRACCARPOSX], fraccar_info[x][FRACCARPOSY], fraccar_info[x][FRACCARPOSZ], fraccar_info[x][FRACCARANGLE], fraccar_info[x][FRACCARCOLOR1], fraccar_info[x][FRACCARCOLOR2], 15, 0);
                SetVehicleToRespawn(x);
			}
		}
	}
	return 1;
}
stock save_gz(gid)
{
	new query[138 + 24 + 24 + 24 + 24 + 4 + 3];
	format(query, sizeof(query), "UPDATE `gangzone` SET `ginfo1` = '%f', `ginfo2` = '%f', `ginfo3` = '%f', `ginfo4` = '%f', `fraction` = '%d' WHERE `id` = '%d' LIMIT 1",
	GZMZ[gid][gCoords1], GZMZ[gid][gCoords2],GZMZ[gid][gCoords3],GZMZ[gid][gCoords4],GZMZ[gid][gFrak], gid+1);
	mysql_tquery(dbHandle, query);
	return 1;
}
stock IsPlayerInBandOnline(bandid)
{
	new np;
	foreach(new i:Player)
	{
		if(player_info[i][FRACTION] == bandid)
		{
			np++;
		}
	}
	return np;
}
stock GetGangZoneColor(gangzonex)
{
	new zx;
	switch(GZMZ[gangzonex][gFrak])
	{
		case F_GROVE: zx = 0x3FDB3765;
		case F_BALLAS: zx = 0xEE15FF90;
		case F_RIFA: zx = 0x1400FF85;
		case F_AZTEC: zx = 0x00EBFF65;
		case F_VAGOS: zx = 0xFFD80765;
		case F_SEVILLE: zx = 0x00FF7F85;
		case F_RHBALLAS: zx = 0xFF007F85;
		case F_TDBALLAS: zx = 0xEE84FF90;
		case F_KTBALLAS: zx = 0x9F00FF55;
		case 0: zx = 0xC0C0C0AA;
	}
	return zx;
}
stock PlayerToKvadrat(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y)
{
	new Float:xxp,Float:yyp,Float:zzp;
	GetPlayerPos(playerid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return 1;
	return 0;
}
stock GetGZColorF(fnumber)
{
	new zx;
	switch(fnumber)
	{
		case F_GROVE: zx = 0x3FDB3765;
		case F_BALLAS: zx = 0xEE15FF90;
		case F_RIFA: zx = 0x1400FF85;
		case F_AZTEC: zx = 0x00EBFF65;
		case F_VAGOS: zx = 0xFFD80765;
		case F_SEVILLE: zx = 0x00FF7F85;
		case F_RHBALLAS: zx = 0xFF007F85;
		case F_TDBALLAS: zx = 0xEE84FF90;
		case F_KTBALLAS: zx = 0x9F00FF55;
		case 0: zx = 0xC0C0C0AA;
	}
	return zx;
}
stock GetGangName(fnumbwer)
{
	new string[128];
	switch(fnumbwer)
	{
		case F_GROVE: format(string,128,"Grove Street Fam.");
		case F_BALLAS: format(string,128,"Front Yard Ballas");
		case F_RIFA: format(string,128,"San Fierro Rifa");
		case F_AZTEC: format(string,128,"Varrio Los Aztecas");
		case F_VAGOS: format(string,128,"Los Santos Vagos");
		case F_SEVILLE: format(string,128,"Seville B.L.V.D Fam.");
		case F_RHBALLAS: format(string,128,"Rollin Heights Ballas");
		case F_TDBALLAS: format(string,128,"Temple Drive Ballas");
		case F_KTBALLAS: format(string,128,"Kilo Tray Ballas");
	}
	return string;
}
stock CaptureStart(familyone, familytwo)
{
    is_capture = true;

	new
		str_mafia1[32],
		str_mafia2[32],
		mes[80];

	foreach(new i:Player)
	{
		if(!IsAGang(i))
			continue;

		TextDrawShowForPlayer(i, BandaCapt1a);
		TextDrawShowForPlayer(i, BandaCapt2a);
		TextDrawShowForPlayer(i, ScoreCapt1a);
		TextDrawShowForPlayer(i, ScoreCapt2a);
		TextDrawShowForPlayer(i, CaptTime);
		TextDrawShowForPlayer(i, ScoreCapt);
		TextDrawShowForPlayer(i, Textdraw4);

		format(str_mafia1, sizeof(str_mafia1), "%s", GetGangName(familyone));
		TextDrawSetString(BandaCapt1a, str_mafia1);

		format(str_mafia2, sizeof(str_mafia2), "%s", GetGangName(familytwo));
		TextDrawSetString(BandaCapt2a, str_mafia2);

		format(str_mafia1, 2, "0");
		TextDrawSetString(ScoreCapt1a, str_mafia1);

		format(str_mafia2, 2, "0");
		TextDrawSetString(ScoreCapt2a, str_mafia2);

		format(mes, sizeof(mes), "%s начала захват территории %s", GetGangName(familyone), GetGangName(familytwo));
		SCMA( CRED, mes);
		format(mes, sizeof(mes), "%s начал захват территории банды %s", player_info[gangstartid][NAME], GetGangName(familytwo));
		SCMA( COLOR_MBLUE, mes);
	}
}
stock CaptureEnd()
{
	foreach(new i: Player)
	{
		if(!IsAGang(i)) continue;
		TextDrawHideForPlayer(i, BandaCapt1a);
		TextDrawHideForPlayer(i, BandaCapt2a);
		TextDrawHideForPlayer(i, ScoreCapt1a);
		TextDrawHideForPlayer(i, ScoreCapt2a);
		TextDrawHideForPlayer(i, CaptTime);
		TextDrawHideForPlayer(i, ScoreCapt);
		TextDrawHideForPlayer(i, Textdraw4);
		IsCapture = 0;
		is_capture = false;
		gangstartid = 0;
	}
	update_gang();
}
stock IsInAllowed(playerid)
{
	new L = sizeof(allowedfactions);
	for(new i =0;i<L;i++)
	{
		if(player_info[playerid][FRACTION] == allowedfactions[i]) return 1;
	}
	return 0;
}
CMD:capture(playerid)
{
    new string[128];
	if(IsAGang(playerid))
	{
		new h; gettime(h);
		if(h < 8 || h > 22) return SCMError(playerid, "Использовать команду можно только с 8:00 до 22:00");
		//if(Ghettoinfo == 1) return SendClientMessage(playerid,COLOR_GREY,"В данный момент гетто заморожено");
		//if(p_info[playerid][pRank] < 9) return SendClientMessage(playerid,WHITE_COLOR,"Функция недоступна");
		new faction = player_info[playerid][FRACTION];
		if(!IsInAllowed(playerid)) return SCMError(playerid, "Ваша банда уже учавствует в захвате зон");
		if(zGangTime[faction] <= 0) return SCMError(playerid, "Сегодня ваша банда больше не может учавствовать в захвате");
		if(FrakCD > 0)
		{
		    new f_str[43];
		    format(f_str,sizeof(f_str),"Ваша банда устала, отдыхайте еще %d минут.", floatround(FrakCD/15));
			SendClientMessage(playerid,CGRAY,f_str);
			return 1;
		}
		for(new i; i< MAX_GANGZONE;i++)
		{
			if(PlayerToKvadrat(playerid, GZMZ[i][gCoords1], GZMZ[i][gCoords2], GZMZ[i][gCoords3], GZMZ[i][gCoords4]))
			{
			    if(ZoneOnBattle[i] == 0)
			    {
				    if(GZMZ[i][gFrak] == player_info[playerid][FRACTION]) return SendClientMessage(playerid, WHITE_COLOR, "Вы не можете захватывать зону вашей банды!");
					//if(IsPlayerInBandOnline(faction) < 5) return SCMError(playerid, "В вашей банде мало игроков онлайн!");
					//if(IsPlayerInBandOnline(GZMZ[i][gFrak]) < 5) return SCMError(playerid, "У банды мало игроков!");
					if(IsCapture == 1) return SendClientMessage(playerid, WHITE_COLOR, "Уже происходит захват одной из зон. Дождитесь окончания!");
					format(string, sizeof(string), "Эта территория принадлежит %s\nВы уверены, что хотите захватить ее?",GetGangName(GZMZ[i][gFrak]));
					SPD(playerid,DLG_CAPTURE,0,"{F3FF02}Захват территории",string,"Да","Нет");
				}
			}
		}
	}
	else return SendClientMessage(playerid,WHITE_COLOR,"Функция недоступна");
	return 1;
}
stock GzCheck()
{
	for(new i; i < MAX_GANGZONE; i++)
	{
		if(ZoneOnBattle[i] == 1 && GZSafeTime[i] == 0)
		{
			if(GangInfo[GZMZ[i][gNapad]][score] > GangInfo[GZMZ[i][gFrak]][score] ||
			GangInfo[GZMZ[i][gNapad]][score] == 0 && GangInfo[GZMZ[i][gFrak]][score] == 0)
			{
			    new string[64];
				new zx,zl;
				zx = GZMZ[i][gNapad];
				zl = i;
				ZoneOnBattle[zl] =0;

				format(string,sizeof(string),"Банда %s захватила новую территорию",GetGangName(zx));
				SCMA(CBLUE, string);

				CaptureEnd();
				GangInfo[GZMZ[zl][gNapad]][captureid] = 0;
				GangInfo[GZMZ[zl][gNapad]][capture] = 0;
				GangInfo[GZMZ[zl][gNapad]][score] = 0;
				GangInfo[GZMZ[zl][gFrak]][captureid] = 0;
				GangInfo[GZMZ[zl][gFrak]][capture] = 0;
				GangInfo[GZMZ[zl][gFrak]][score] = 0;
				GangInfo[GZMZ[i][gNapad]][gangnumber] = 0;
				GangInfo[GZMZ[i][gFrak]][gangnumber] = 0;
				GZMZ[zl][gFrak] = zx;
				GZMZ[zl][gNapad] = 0;
				GangZoneStopFlashForAll(GZMZ[zl][gCreate]);
				GangZoneHideForAll(GZMZ[zl][gCreate]);
				GangZoneShowForAll(GZMZ[zl][gCreate],GetGangZoneColor(zl));
				save_gz(zl);
				update_gang();
			}
			else if(GangInfo[GZMZ[i][gNapad]][score] < GangInfo[GZMZ[i][gFrak]][score] ||
			GangInfo[GZMZ[i][gNapad]][score] == GangInfo[GZMZ[i][gFrak]][score])
			{
			    new string[64];
				new zx,zl;
				zx = GZMZ[i][gFrak];
				zl = i;

				format(string,sizeof(string),"Попытка захватить территорию %s провалилась",GetGangName(zx));
				SCMA(0xff2400FF, string);
				/*SCM(F_BALLAS,0xff2400FF, string);
				SCM(F_AZTEC,0xff2400FF, string);
				SCM(F_RIFA,0xff2400FF, string);
				SCM(F_VAGOS,0xff2400FF, string);*/

				ZoneOnBattle[zl] =0;
				CaptureEnd();
				GangInfo[GZMZ[zl][gNapad]][captureid] = 0;
				GangInfo[GZMZ[zl][gNapad]][capture] = 0;
				GangInfo[GZMZ[zl][gNapad]][score] = 0;
				GangInfo[GZMZ[zl][gFrak]][captureid] = 0;
				GangInfo[GZMZ[zl][gFrak]][capture] = 0;
				GangInfo[GZMZ[zl][gFrak]][score] = 0;
				GangInfo[GZMZ[i][gNapad]][gangnumber] = 0;
				GangInfo[GZMZ[i][gFrak]][gangnumber] = 0;
				GZMZ[zl][gFrak] = zx;
				GZMZ[zl][gNapad] = 0;
				GangZoneStopFlashForAll(GZMZ[zl][gCreate]);
				GangZoneHideForAll(GZMZ[zl][gCreate]);
				GangZoneShowForAll(GZMZ[zl][gCreate],GetGangZoneColor(zl));
				save_gz(zl);
				update_gang();
			}
		}
	}
	for(new i; i < MAX_GANGZONE;i++)
	{
		for(new z = 0;z<50;z++)
		{
			OnZONE[i][z] =0;
		}
	}
	return 1;
}
stock update_gang()
{
	for(new i;i<9;i++) TotalGz[i] = 0;

	for(new i; i < MAX_GANGZONE; i++)
	{
		switch(GZMZ[i][gFrak])
		{
			case F_BALLAS: TotalGz[0]++;
			case F_GROVE: TotalGz[1]++;
			case F_AZTEC: TotalGz[2]++;
			case F_VAGOS: TotalGz[3]++;
			case F_RIFA: TotalGz[4]++;
			case F_SEVILLE: TotalGz[5]++;
			case F_RHBALLAS: TotalGz[6]++;
			case F_TDBALLAS: TotalGz[7]++;
			case F_KTBALLAS: TotalGz[8]++;
		}
  	}
}
stock Converts(number)
{
	new hours = 0, mins = 0, secs = 0, string[30];
	hours = floatround(number / 3600);
	mins = floatround((number / 60) - (hours * 60));
	secs = floatround(number - ((hours * 3600) + (mins * 60)));
	if(hours > 0) format(string, 30, "%d:%02d:%02d", hours, mins, secs);
	else format(string, 30, "%d:%02d", mins, secs);
	return string;
}
@__sec_timer();
@__sec_timer()
{
    if(FrakCD > 0 && IsCapture == 0) FrakCD--;
    GzCheck();
    for(new i; i < MAX_GANGZONE; i++)
	{
		if(GZSafeTime[i] > 0)
		{
			GZSafeTime[i]--;
			TextDrawSetString(CaptTime, Converts(GZSafeTime[i]));
   			if(GZSafeTime[i] == 60 || GZSafeTime[i] == 600)
			{
			    new string[127];
                format(string,127,"До окончания захвата территории осталось %d секунд.",GZSafeTime[i]);
				SCMA(0xff2400FF,string);
			}
			if(GZSafeTime[i] == 0 && ZoneOnBattle[i] == 1)
			{
			    new string[127];
  				format(string,127,"Захват территории был окончен!");
				SCMA(0xff2400FF,string);
			}
		}
	}
	new h, m;
	gettime(h,m);
	if(gCurMinutes != m)
	{
 		gCurMinutes = m;
		if(m == 0) FracPayDay();
	}
	return 1;
}
CMD:gzcolor(playerid,params[])
{
    if(player_info[playerid][ADMIN] < 4) return 1;
    if(sscanf(params,"d",params[0])) return SendClientMessage(playerid, WHITE_COLOR, "/gzcolor [GANG ID]");
    if(!(0 <= params[1] <= 9)) return SCM(playerid, RED_COLOR, "GANG ID must be 1 - 9!");
 	for(new i; i <= MAX_GANGZONE; i++)
	{
		if(PlayerToKvadrat(playerid, GZMZ[i][gCoords1], GZMZ[i][gCoords2], GZMZ[i][gCoords3], GZMZ[i][gCoords4]))
		{
			GZMZ[i][gFrak] = params[0];
			GangZoneStopFlashForAll(GZMZ[i][gCreate]);
			GangZoneHideForAll(GZMZ[i][gCreate]);
			GangZoneShowForAll(GZMZ[i][gCreate], GetGangZoneColor(i));
			save_gz(i);
			if(i+1 == GZMZ[i][idm])
			{
			    new string[40];
			    format(string, sizeof(string), "You have changed %d gangzone color", GZMZ[i][idm]);
			    SCM(playerid, COLOR_LIGHTBLUE, string);
			}
			return 1;
		}
	}
    return 1;
}
CMD:agun(playerid,params[])
{
	if(player_info[playerid][ADMIN] < 4) return 1;
 	if(sscanf(params, "ddd", params[0],params[1],params[2])) return SendClientMessage(playerid,CGRAY,"/agun [ID игрока] [ID оружия] [патроны]");
	new id = params[0];
 	new gun = params[1];
	new ammo = params[2];
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GRAD1, !"Wrong ID");
	if(GetPVarInt(params[0], "logged") == 0) return SCM(playerid, RED_COLOR, !"Player is not logged in");
	new string[64];
	new weapname[50];
	GetWeaponName(gun, weapname, sizeof weapname);
	format(string, sizeof(string), "Вы выдали игроку %s %s с %d патронами",player_info[params[0]][NAME],weapname, ammo);
	SendClientMessage(playerid, COLOR_GRAD1, string);
	GivePlayerWeapon(id, gun, ammo);
	return 1;
}
stock SetPlayerSkills(playerid)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, player_info[playerid][GUNSKILL][1]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 55);
	//SetPlayerSkillLevel(playerid, WEAPONSKILL_TEC9, player_info[playerid][GUNSKILL][3]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 100);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, player_info[playerid][GUNSKILL][0]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, player_info[playerid][GUNSKILL][2]*10);
	return 1;
}
stock ToDevelopSkills(Slashes, Points)
{
	new string[149];
	new Slash[2] = "|";
	new Point[2] = ".";
	for(new i = 0; i < Slashes; i++) strcat(string, Slash);
	for(new i = 0; i < Points; i++) strcat(string, Point);
	return string;
}
stock Float:PointToPoint3D(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2) return floatsqroot(floatadd(floatadd(floatpower(x2-x1,2),floatpower(y2-y1,2)),floatpower(z2-z1,2)));
stock Float:PointToPoint2D(Float:x1,Float:y1,Float:x2,Float:y2) return floatsqroot(floatadd(floatpower(x2-x1,2),floatpower(y2-y1,2)));
stock Float:GetPlayerDistanceToPlayer(playerid, targetid)
{
    new Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerPos(targetid, x2, y2, z2);
    return PointToPoint2D(x, y, x2, y2);
}
CMD:skill(playerid,params[])
{
	if(sscanf(params, "d", params[0])) return SendClientMessage(playerid,CGRAY,"/skill [ID игрока]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,CGRAY,"Неверный ID");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 3.0 || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) return SendClientMessage(playerid,CGRAY,"Вы далеко друг от друга");
	if(params[0] != playerid)
	{
		new mes[128];
		format(mes,sizeof(mes),"Вы предложили {"#cW"}%s{"#cINFO"} показать выписку из тира",player_info[params[0]][NAME]);
		SendClientMessage(playerid,CINFO,mes);
		format(mes,sizeof(mes),"%s {"#cINFO"}хочет показать Вам выписку из тира. Чтобы подтвердить нажмите {"#cGREEN"}Y{"#cINFO"}, иначе {"#cRED"}N",player_info[playerid][NAME]);
		SendClientMessage(params[0],CWHITE,mes);
		player_info[params[0]][SHOWSKILLPL] = playerid;
		player_info[params[0]][SHOWSKILLAC] = params[0];
	}
	if(params[0] == playerid)
	{
		new strkill[406];
		new points[3];
		points[0] = 100 - player_info[playerid][GUNSKILL][0];
		points[1] = 100 - player_info[playerid][GUNSKILL][1];
		points[2] = 100 - player_info[playerid][GUNSKILL][2];
		//points[3] = 100 - player_info[playerid][GUNSKILL][3];
		format(strkill,406,"{"#cW"}Pistol:\t\t[%s]%d\nDeagle:\t[%s]%d\nMicroUZI/Tec9:\t[%s]%d",
		ToDevelopSkills(player_info[playerid][GUNSKILL][0],points[0]),player_info[playerid][GUNSKILL][0],
		ToDevelopSkills(player_info[playerid][GUNSKILL][1],points[1]),player_info[playerid][GUNSKILL][1],
		ToDevelopSkills(player_info[playerid][GUNSKILL][2],points[2]), player_info[playerid][GUNSKILL][2]);
		//ToDevelopSkills(player_info[playerid][GUNSKILL][3],points[3]), player_info[playerid][GUNSKILL][3]);
		SPD(playerid,DLG_MES,0,"{"#cBL"}Навыки владения оружием",strkill,"Закрыть","");
	}
	return 1;
}
stock set_player_default(playerid)
{
	SPD(playerid, -1, 0, "", "", "", "");
	player_info[playerid][SHOWSKILLPL] = -1;
	return 1;
}
CMD:ggps(playerid)
{
	if(!IsAGang(playerid)) return 1;
	SPD(playerid, DLG_GGPS, DIALOG_STYLE_LIST, !"Gang Navigator",
	!"{"#cBL"}Car Black Market\n{"#cBL"}Gun Black Market", !"Select", !"Close");
	return 1;
}
CMD:givemoney(playerid,params[])
{
    if(player_info[playerid][ADMIN] < 4) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /givemoney ID count");
    if(!(-9999999 <= params[1] <= 9999999)) return SCM(playerid, RED_COLOR, !"count id must be -9999999 - 9999999");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    player_info[params[0]][MONEY] += params[1];
    new string[60+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), "Administrator %s gave you %d money", player_info[playerid][NAME], params[1]);
	SCM(params[0], WHITE_COLOR, string);
	static const fmt_query[] = "UPDATE `users` SET `money` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+24)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][MONEY], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:setrang(playerid,params[])
{
    if(player_info[playerid][ADMIN] < 6) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /setrang ID [1-10]");
    if(!(1 <= params[1] <= 10)) return SCM(playerid, RED_COLOR, !"count id must be 1 - 10");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(player_info[params[0]][FRACTION] == 0) return SCM(playerid, RED_COLOR, !"Player is not a fraction member");
    player_info[params[0]][FRACTIONRANG] = params[1];
    new string[60+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), "Administrator %s gave you %d rank in your fraction", player_info[playerid][NAME], params[1]);
	SCM(params[0], RED_COLOR, string);
	static const fmt_query[] = "UPDATE `users` SET `fractionrang` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][FRACTIONRANG], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:sethp(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 6) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /sethp ID count");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(!(0 <= params[1] <= 160)) return SCMError(playerid, !"HP count must be 0 - 160");
    SetPlayerHealth(params[0], params[1]);
    new string[60+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), "Administrator %s gave you %d HP", player_info[playerid][NAME], params[1]);
	SCM(params[0], RED_COLOR, string);
	format(string, sizeof(string), "You gave to %s %d HP", player_info[params[0]][NAME], params[1]);
	SCM(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}
CMD:setarmour(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 6) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /setarmour ID count");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(!(0 <= params[1] <= 100)) return SCMError(playerid, !"Armour count must be 0 - 100");
    SetPlayerArmour(params[0], params[1]);
    new string[60+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), "Administrator %s gave you %d Armour", player_info[playerid][NAME], params[1]);
	SCM(params[0], RED_COLOR, string);
	format(string, sizeof(string), "You gave to %s %d Armour", player_info[params[0]][NAME], params[1]);
	SCM(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}
CMD:setskin(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 6) return 1;
    if(sscanf(params, "dd", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /setskin ID count");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(!(1 <= params[1] <= 311)) return SCMError(playerid, !"Skin count must be 1 - 311");
    if(params[1] == 2 || params[1] == 265 || params[1] == 266 || params[1] == 267 || params[1] == 269 || params[1] == 270 || params[1] == 271 || params[1] == 273 || params[1] == 293 || params[1] == 294 || params[1] == 295 || params[1] == 296 || params[1] == 297 || params[1] == 298 || params[1] == 299 || params[1] == 6) return SCMError(playerid, !"Wrong Skin!");
    SetPlayerSkin(params[0], params[1]);
    player_info[params[0]][SKIN] = params[1];
    new string[120+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), !"Administrator %s gave you %d Skin ID", player_info[playerid][NAME], params[1]);
	SCM(params[0], RED_COLOR, string);
	format(string, sizeof(string), !"You gave to %s %d Skin ID", player_info[params[0]][NAME], params[1]);
	SCM(playerid, COLOR_LIGHTBLUE, string);
	static const fmt_query[] = "UPDATE `users` SET `skin` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][SKIN], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:kick(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 7) return 1;
    if(sscanf(params, "ds[62]", params[0], params[1])) return SCM(playerid, RED_COLOR, !"Type /kick ID reason");
    if(player_info[params[0]][ADMIN] > 0) return SCMError(playerid, !"You can't kick administration");
    if(GetPVarInt(params[0], "logged") != 1) return SCMError(playerid, !"Player is not logged in");
    new string[120+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), !"Administrator %s kicked %s reason: %s", player_info[playerid][NAME], player_info[params[0]][NAME], params[1]);
	SendClientMessageToAll(COLOR_BLUE, string);
	Kick(params[0]);
	return 1;
}
CMD:uval(playerid, params[])
{
    if(player_info[playerid][ADMIN] < 6) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, RED_COLOR, !"Type /uval ID");
    if(GetPVarInt(params[0], "logged") != 1) return SCM(playerid, RED_COLOR, !"Player is not logged in");
    if(player_info[params[0]][FRACTION] == 0) return SCM(playerid, RED_COLOR, !"Player is not a fraction member");
    player_info[params[0]][FRACTION] = 0;
    player_info[params[0]][LFRACTION] = 0;
    player_info[params[0]][FRACTIONRANG] = 0;
    SetPlayerColor(playerid, 0xFFFFFF80);
    new string[60+(-2+MAX_PLAYER_NAME)];
    format(string, sizeof(string), "Administrator %s dismiss you from fraction", player_info[playerid][NAME]);
	SCM(params[0], RED_COLOR, string);
	format(string, sizeof(string), "You dismissed %s from fraction", player_info[params[0]][NAME]);
	SCM(params[0], COLOR_LIGHTBLUE, string);
	static const fmt_query[] = "UPDATE `users` SET `fraction` = '%d', `lfraction` = '%d', `fractionrang` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+8)+(-2+8)+(-2+8)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[params[0]][FRACTION], player_info[params[0]][LFRACTION], player_info[params[0]][FRACTIONRANG], player_info[params[0]][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
CMD:leaders(playerid)
{
    new buf[112], afk[6];
	new string[2048];
    buf = "\tОрганизация - Имя:\n{FFFFFF}";
	strcat(string, buf);
	foreach(new i:Player)
	{
	    if(player_info[i][LFRACTION] > 0)
	    {
		    if(AFK[i] > 5)
		    {
		        afk = "- AFK";
		    }
		    else
		    {
		        afk = "";
		    }
		    new idfrac = player_info[i][LFRACTION];
		    format(buf, sizeof(buf), "%s - %s %s\n", gFractionName[idfrac], player_info[i][NAME], afk);
			strcat(string, buf);
		}
	}
	SPD(playerid, DLG_MES, DIALOG_STYLE_MSGBOX, "{"#cBL"}Лидеры {FFFFFF}онлайн", string, "Закрыть", "");
	return 1;
}
stock isNumeric(const string[])
{
  new length=strlen(string);
  if (length<=0) return false;
  for (new i = 0; i < length; i++)
    {
      if (
            (string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') 
             || (string[i]=='-' && i!=0)
             || (string[i]=='+' && i!=0)                                             
         ) return false;
    }
  if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
  return 1;
}
forward IsVehicleOccupied(vehicleid);
public IsVehicleOccupied(vehicleid)
{
	foreach(new i:Player)
	{
		if(IsPlayerInVehicle(i,vehicleid)) return true;
	}
	return false;
}
CMD:fraccarrespawn(playerid)
{
	new x;
	new fractionid = player_info[playerid][FRACTION];
	new mesid[80];
	if(player_info[playerid][LFRACTION] < 1 || player_info[playerid][FRACTIONRANG] < 9) return SCMError(playerid, "You cant use this command");
    for(new cars; cars < MAXFRACCAR; cars++)
	{
    	x = cars + 1;
    	if(fraccar_info[x][FRACCARNUMBER] == player_info[playerid][LFRACTION])
    	{
            if(!IsVehicleOccupied(x)) SetVehicleToRespawn(x);
		}
	}
	format(mesid,sizeof(mesid),"[F] (( Leader %s respawned all fraction unoccupied vehicles ))", player_info[playerid][NAME]);
	SendFMes(fractionid, CBLUE, mesid);
	return 1;
}
CMD:id(playerid, params[])
{
    if(GetPVarInt(playerid, "logged") != 1) return 1;
    new tmp[MAX_PLAYER_NAME+1];
    if(sscanf(params, "s[44]", tmp)) return SendClientMessage(playerid, CGRAY, "/id [ID или никнейм игрока]");
    new id=-1, name[38];
    if(!isNumeric(tmp))
    {
        SendClientMessage(playerid,CBLUE,"Игроки онлайн:");
        foreach(new i:Player)
        {
            if(GetPVarInt(i, "logged") != 1 || player_info[i][ADMIN] > 7) continue;
            GetPlayerName(i, name, sizeof(name));
            if(strfind(name, tmp, true) != -1)
            {
                if(id >= 4)
                {
                    id++;
                    continue;
                }
                format(name, sizeof(name), "%s[%d]", name, i);
                SendClientMessage(playerid, CWHITE, name);
                id++;
            }
        }
        if(id == -1) return SendClientMessage(playerid, CWHITE, "Ничего не найдено");
        else if(id >= 4)
        {
            format(name,sizeof(name),"Показано 5 найденных из %d", id-2);
            SendClientMessage(playerid, CWHITE, name);
        }
    }
    else
    {
        id = strval(tmp);
        if(!IsPlayerConnected(id)) return SCMError(playerid, "Неверный ID");
        if(GetPVarInt(id, "logged") != 1) return SCMError(playerid, "Игрок не авторизовался");
        GetPlayerName(id, name, sizeof(name));
        SendClientMessage(playerid, CBLUE, "Игроки онлайн:");
        format(name,sizeof(name),"%s[%d]", name, id);
        SendClientMessage(playerid, CWHITE, name);
    }
    return 1;
}
stock GetYearDayCount(year)
{
	if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) return 366;
	else return 365;
}
stock GetDayNumber()
{
	new d,m,y,diff,daycount,cdaycount;
	getdate(y,m,d);
	diff = y - 2012;
	for(new i;i<diff;i++) daycount += GetYearDayCount(i+2012);
	cdaycount = GetYearDayCount(y);
	new Mon[12];
	if(cdaycount == 365) Mon = {0,31,59,90,120,151,181,212,243,273,304,334};
	else Mon = {0,31,60,91,121,152,182,213,244,274,305,335};
	m -= 1; 
	new result = daycount+Mon[m]+d;
	return result;
}
CMD:time(playerid)
{
	new h, m, s;
	gettime(h, m, s);
	new year, month, day;
	getdate(year, month, day);
	new mes[50];
	new mes2[100];
	format(mes2, sizeof(mes2),"Время: {"#cBL"}%d:%02d\n {FFFFFF}Дата: {"#cBL"}%02d-%02d-%d", h ,m, day, month, year - 29);
	SCM(playerid, WHITE_COLOR, mes2);
	format(mes, sizeof(mes),"~b~%d:%02d ~n~~b~%02d-%02d-%d", h ,m, day, month, year - 29);
	GameTextForPlayer(playerid, mes, 5000, 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,0,0,0,2000,1);
	}
	return 1;
}

CMD:f(playerid,params[])
{
    if(!IsAGang(playerid)) return SendClientMessage(playerid, CGRAY, "Ошибка: Вам недоступна эта функция");
	//if(p_info[playerid][pMuteTime]) return SendClientMessage(playerid,CGRAY,"У вас бан чата. Используйте /mutetime чтобы узнать время бана.");
	//if(!(p_info[playerid][pSettings] & setFractionChat)) return SendClientMessage(playerid,CGRAY,"Ошибка: Включите чат фракции в личных настройках");
	if(sscanf(params, "s[128]", params[0])) return SendClientMessage(playerid, CGRAY, "/f [текст]");
	new fractionid = player_info[playerid][FRACTION];
	new rank = player_info[playerid][FRACTIONRANG];
	new mesid[256];
	//SetPlayerChatBubble(playerid, "Сказал что-то в рацию", CPINK, 10.0, 3000);
	format(mesid,sizeof(mesid),"[F] %s %s[%d]: %s", gFractionRankName[fractionid][rank], player_info[playerid][NAME], playerid, params[0]);
    if(fractionid+1 == 11 && rank <= 9)
    format(mesid,sizeof(mesid),"[F] %s %s[%d]: %s", gFractionRankName[fractionid][rank], player_info[playerid][NAME], playerid, params[0]);
	SendFMes(fractionid, CBLUE, mesid);
	return 1;
}
CMD:fb(playerid,params[])
{
    if(!IsAGang(playerid)) return SendClientMessage(playerid, CGRAY, "Ошибка: Вам недоступна эта функция");
	//if(p_info[playerid][pMuteTime]) return SendClientMessage(playerid,CGRAY,"У вас бан чата. Используйте /mutetime чтобы узнать время бана.");
	//if(!(p_info[playerid][pSettings] & setFractionChat)) return SendClientMessage(playerid,CGRAY,"Ошибка: Включите чат фракции в личных настройках");
	if(sscanf(params, "s[128]", params[0])) return SendClientMessage(playerid, CGRAY, "/f [текст]");
	new fractionid = player_info[playerid][FRACTION];
	new rank = player_info[playerid][FRACTIONRANG];
	new mesid[256];
	//SetPlayerChatBubble(playerid, "Сказал что-то в рацию", CPINK, 10.0, 3000);
	format(mesid,sizeof(mesid),"[F] (( %s %s[%d]: %s ))", gFractionRankName[fractionid][rank], player_info[playerid][NAME], playerid, params[0]);
    if(fractionid+1 == 11 && rank <= 9)
    format(mesid,sizeof(mesid),"[F] (( %s %s[%d]: %s ))", gFractionRankName[fractionid][rank], player_info[playerid][NAME], playerid, params[0]);
	SendFMes(fractionid, CBLUE, mesid);
	return 1;
}
CMD:usedrugs(playerid)
{
	if(player_info[playerid][HEROIN] < 1) return SCMError(playerid, "You dont have drugs");
	if(usedrugsbuff[playerid] != 0) return SCMError(playerid, "You already used a drug");
	player_info[playerid][HEROIN] -= 1;
	usedrugsbuff[playerid] = 1;
	SetPlayerWeather(playerid, 44);
	ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1,0,0,0,0,0,1);
    narcotimer = SetTimerEx( "NarkoTimer", 60000*5 , false, "i", playerid);
    static const fmt_query[] = "UPDATE `users` SET `heroin` = '%d' WHERE `id` = '%d' LIMIT 1";
	new query[sizeof(fmt_query)+(-2+20)+(-2+11)];
	mysql_format(dbHandle, query, sizeof(query), fmt_query, player_info[playerid][HEROIN], player_info[playerid][ID]);
	mysql_query(dbHandle, query);
	return 1;
}
stock SendFMes(fact, color, str[])
{
	if(fact == 12) fact = 9;
	else if(fact == 9) fact = 12;
	foreach(new i:Player)
	{
		if(player_info[i][FRACTION] == fact) SendClientMessage(i, color, str);
		else if((fact == 12 && player_info[i][FRACTION] == 9) || (fact == 9 && player_info[i][FRACTION] == 12)) SendClientMessage(i, color, str);
	}
	return 1;
}
stock clear_player(playerid)
{
	player_info[playerid][ID] = 0;
	player_info[playerid][NAME] = 0;
	player_info[playerid][EMAIL] = 0;
    player_info[playerid][SEX] = 0;
    player_info[playerid][AGE] = 0;
    player_info[playerid][RACE] = 0;
    player_info[playerid][ADMIN] = 0;
    player_info[playerid][SKIN] = 0;
    player_info[playerid][VOZRAST] = 0;
    player_info[playerid][VOZRASTEXP] = 0;
    player_info[playerid][MINUTES] = 0;
    player_info[playerid][MONEY] = 0;
    player_info[playerid][FRACTION] = 0;
    player_info[playerid][LFRACTION] = 0;
    player_info[playerid][FRACTIONRANG] = 0;
    player_info[playerid][HEROIN] = 0;
    player_info[playerid][SHOWSKILLAC] = -1;
    player_info[playerid][SHOWSKILLPL] = -1;
    /*player_info[playerid][GUNSKILL[0]] = -1;
    player_info[playerid][GUNSKILL[1]] = 0;
    player_info[playerid][GUNSKILL[2]] = 0;*/
	AFK[playerid] = -2;
}
stock Checkarmour(playerid)
{
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if(armour != 0)
	{
		SetPlayerAttachedObject(playerid, 9, 19515, 1, 0.046000, 0.050999, 0.000000, 0.000000, 0.000000, 0.000000, 1.087000, 1.26, 1.189999);
	}
	else { RemovePlayerAttachedObject(playerid, 9); }
}
