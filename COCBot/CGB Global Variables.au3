; #FUNCTION# ====================================================================================================================
; Name ..........: CGB Global Variables
; Description ...: This file Includes several files in the current script and all Declared variables, constant, or create an array.
; Syntax ........: #include , Global
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: www.Gabenk-like.ml
; Example .......: No
; ===============================================================================================================================

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <GuiSlider.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
;#include <WindowsConstants.au3> ; included on CGB Bot.au3
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Array.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <INet.au3>
#include <GuiTab.au3>
#include <String.au3>
#include <IE.au3>

Global Const $COLOR_ORANGE = 0xFFA500
Global Const $bCapturePixel = True, $bNoCapturePixel = False

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions
Global $hBitmapScreenshot; Image for screenshot functions
Global $hHBitmapScreenshot; Handle Image for screenshot functions
;Global $sFile = @ScriptDir & "\Icons\logo.gif"

Global $Title = "BlueStacks App Player" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window

Global $sCurrProfile = "01"
Global $iVillageName
Global $sProfilePath = @ScriptDir & "\Profiles"
Global $sTemplates = @ScriptDir & "\Templates"
If FileExists($sProfilePath & "\profile.ini") Then
	$sCurrProfile = IniRead($sProfilePath & "\profile.ini", "general", "defaultprofile", "01")
EndIf
Global $config = $sProfilePath & "\" & $sCurrProfile & "\config.ini"
Global $building = $sProfilePath & "\" & $sCurrProfile & "\building.ini"
Global $dirLogs = $sProfilePath & "\" & $sCurrProfile & "\Logs\"
Global $dirLoots = $sProfilePath & "\" & $sCurrProfile & "\Loots\"
Global $dirTemp = $sProfilePath & "\" & $sCurrProfile & "\Temp\"
Global $LibDir = @ScriptDir & "\lib" ;lib directory contains dll's
Global $pFuncLib = $LibDir & "\CGBFunctions.dll" ; functions library
Global $pIconLib = $LibDir & "\CGBBOT.dll" ; icon library
; enumerated Icons 1-based index to IconLib
Global Enum $eIcnArcher = 1, $eIcnDonArcher, $eIcnBalloon, $eIcnDonBalloon, $eIcnBarbarian, $eIcnDonBarbarian, $eIcnKing, $eIcnBuilder, $eIcnCC, $eIcnGUI, $eIcnDark, $eIcnDragon, $eIcnDonDragon, $eIcnDrill, $eIcnElixir, $eIcnCollector, $eIcnFreezeSpell, $eIcnGem, $eIcnGiant, $eIcnDonGiant, _
		$eIcnTrap, $eIcnGoblin, $eIcnDonGoblin, $eIcnGold, $eIcnGolem, $eIcnDonGolem, $eIcnHealer, $eIcnDonHealer, $eIcnHogRider, $eIcnDonHogRider, $eIcnHealSpell, $eIcnInferno, $eIcnJumpSpell, $eIcnLavaHound, $eIcnDonLavaHound, $eIcnLightSpell, $eIcnMinion, $eIcnDonMinion, $eIcnPekka, $eIcnDonPekka, _
		$eIcnQueen, $eIcnRageSpell, $eIcnTroops, $eIcnHourGlass, $eIcnTH1, $eIcnTH10, $eIcnTrophy, $eIcnValkyrie, $eIcnDonValkyrie, $eIcnWall, $eIcnWallBreaker, $eIcnDonWallBreaker, $eIcnWitch, $eIcnDonWitch, $eIcnWizard, $eIcnDonWizard, $eIcnXbow, $eIcnBarrackBoost, $eIcnMine, $eIcnCamp, _
		$eIcnBarrack, $eIcnSpellFactory, $eIcnDonBlacklist, $eIcnSpellFactoryBoost, $eIcnMortar, $eIcnWizTower, $eIcnPayPal, $eIcnPushBullet, $eIcnGreenLight, $eIcnLaboratory, $eIcnRedLight, $eIcnBlank, $eIcnYellowLight, $eIcnDonCustom, $eIcnTombstone, $eIcnSilverStar, $eIcnGoldStar, $eIcnDarkBarrack, _
		$eIcnCollectorLocate, $eIcnDrillLocate, $eIcnMineLocate, $eIcnBarrackLocate, $eIcnDarkBarrackLocate, $eIcnDarkSpellFactoryLocate, $eIcnDarkSpellFactory
Global $eIcnDonBlank = $eIcnDonBlacklist
Global $aDonIcons[17] = [$eIcnDonBarbarian, $eIcnDonArcher, $eIcnDonGiant, $eIcnDonGoblin, $eIcnDonWallBreaker, $eIcnDonBalloon, $eIcnDonWizard, $eIcnDonHealer, $eIcnDonDragon, $eIcnDonPekka, $eIcnDonMinion, $eIcnDonHogRider, $eIcnDonValkyrie, $eIcnDonGolem, $eIcnDonWitch, $eIcnDonLavaHound, $eIcnDonBlank]
Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $sAttackLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $hAttackLogFileHandle
Global $iCmbLog = 0
Global $Restart = False
Global $RunState = False
Global $TakeLootSnapShot = True
Global $ScreenshotLootInfo = False
Global $AlertSearch = True
Global $iChkAttackNow, $iAttackNowDelay, $bBtnAttackNowPressed = False
Global $PushToken = ""

Global Enum $DB, $LB, $TS, $TB, $DT
Global $iModeCount = 2
Global $iMatchMode ; 0 Dead / 1 Live / 2 TH Snipe / 3 TH Bully / 4 Drop Trophy
Global $sModeText[5]
$sModeText[$DB] = "Dead Base"
$sModeText[$LB] = "Live Base"
$sModeText[$TS] = "TH Snipe"
$sModeText[$TB] = "TH Bully"
$sModeText[$DT] = "Drop Trophy"

;PushBullet---------------------------------------------------------------
Global $PBRemoteControlInterval = 60000 ; 60 secs
Global $PBDeleteOldPushesInterval = 1800000 ; 30 mins
Global $iOrigPushB
Global $iLastAttack
Global $iAlertPBVillage
Global $pEnabled
Global $pRemote
Global $pMatchFound
Global $pLastRaidImg
Global $iAlertPBLastRaidTxt
Global $pWallUpgrade
Global $pOOS
Global $pTakeAbreak
Global $pAnotherDevice
Global $sLogFName
Global $sAttackLogFName
Global $AttackFile
Global $RequestScreenshot = 0
Global $iDeleteAllPushes = 0
Global $iDeleteAllPushesNow = False
Global $ichkDeleteOldPushes
Global $icmbHoursPushBullet
Global $chkDeleteAllPushes
Global $ichkAlertPBCampFull
Global $ichkAlertPBCampFullTest = 0
Global $cmbTroopComp ;For Event change on ComboBox Troop Compositions
Global $iCollectCounter = 0 ; Collect counter, when reaches $COLLECTATCOUNT, it will collect
Global $COLLECTATCOUNT = 8 ; Run Collect() after this amount of times before actually collect

;---------------------------------------------------------------------------------------------------
Global $BSpos[2] ; Inside BlueStacks positions relative to the screen
;---------------------------------------------------------------------------------------------------
;Stats
Global $iGoldLoot, $iElixirLoot, $iDarkLoot, $iTrophyLoot
Global $GoldCount, $ElixirCount, $DarkCount, $TrophyCount
Global $FreeBuilder, $TotalBuilders, $GemCount
Global $GoldStart, $ElixirStart, $DarkStart, $TrophyStart
Global $GoldVillage, $ElixirVillage, $DarkVillage, $TrophyVillage
Global $GoldLast, $ElixirLast, $DarkLast, $TrophyLast
Global $CostGoldWall, $CostElixirWall
Global $CostGoldUpgrades = 0, $CostElixirUpgrades = 0, $CostDElixirUpgrades = 0

;Global $costspell

;Search Settings
Global $Is_ClientSyncError = False ;If true means while searching Client Out Of Sync error occurred.
Global $searchGold, $searchElixir, $searchDark, $searchTrophy, $searchTH ;Resources of bases when searching
Global $SearchGold2 = 0, $SearchElixir2 = 0, $iStuck = 0, $iNext = 0
Global $iCmbSearchMode
Global $iMinGold[$iModeCount], $iMinElixir[$iModeCount], $iMinGoldPlusElixir[$iModeCount], $iMinDark[$iModeCount], $iMinTrophy[$iModeCount], $iMaxTH[$iModeCount], $iEnableAfterCount[$iModeCount], $iCmbWeakMortar[$iModeCount], $iCmbWeakWizTower[$iModeCount] ; Minimum Resources conditions
Global $iAimGold[$iModeCount], $iAimElixir[$iModeCount], $iAimGoldPlusElixir[$iModeCount], $iAimDark[$iModeCount], $iAimTrophy[$iModeCount], $iAimTHtext[$iModeCount] ; Aiming Resource values
Global $iChkSearchReduction
Global $ReduceCount, $ReduceGold, $ReduceElixir, $ReduceGoldPlusElixir, $ReduceDark, $ReduceTrophy ; Reducing values
;Global $chkConditions[7], $ichkMeetOne ;Conditions (meet gold...)
;Global $icmbTH
Global $iChkEnableAfter[$iModeCount], $iCmbMeetGE[$iModeCount], $iChkMeetDE[$iModeCount], $iChkMeetTrophy[$iModeCount], $iChkMeetTH[$iModeCount], $iChkMeetTHO[$iModeCount], $iChkMeetOne[$iModeCount], $iCmbTH[$iModeCount], $iChkWeakBase[$iModeCount]
Global $THLocation
Global $THx = 0, $THy = 0
Global $DESLoc
Global $DESLocx = 0
Global $DESLocy = 0
Global $THText[5] ; Text of each Townhall level
$THText[0] = "4-6"
$THText[1] = "7"
$THText[2] = "8"
$THText[3] = "9"
$THText[4] = "10"
Global $SearchCount = 0 ;Number of searches
Global $THaddtiles, $THside, $THi
Global $SearchTHLResult = 0
Global $BullySearchCount = 0
Global $OptBullyMode = 0
Global $OptTrophyMode
Global $ATBullyMode
Global $YourTH
Global $iTHBullyAttackMode
Global $AttackTHType
;Global $chklightspell
;Global $iLSpellQ

Global $TrainSpecial = 1 ;0=Only trains after atk. Setting is automatic
Global $cBarbarian = 0, $cArcher = 0, $cGoblin = 0, $cGiant = 0, $cWallbreaker = 0, $cWizard = 0, $cBalloon = 0, $cDragon = 0, $cPekka = 0, $cMinion = 0, $cHogs = 0, $cValkyrie = 0, $cGolem = 0, $cWitch = 0, $cLavaHound = 0
;Troop types
Global Enum $eBarb, $eArch, $eGiant, $eGobl, $eWall, $eBall, $eWiza, $eHeal, $eDrag, $ePekk, $eMini, $eHogs, $eValk, $eGole, $eWitc, $eLava, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell
;wall
Global $wallcost
Global $wallbuild
Global $walllowlevel
Global $iwallcost
Global $iwallcostelix
Global $Wallgoldmake = 0
Global $Wallelixirmake = 0
Global $WallX = 0, $WallY = 0, $WallLoc = 0
Global $Wallv[8]
Global $wallh[8]
Global $Wall[8]

;Attack Settings
Global $TopLeft[5][2] = [[79, 281], [170, 205], [234, 162], [296, 115], [368, 66]]
Global $TopRight[5][2] = [[480, 63], [540, 104], [589, 146], [655, 190], [779, 278]]
Global $BottomLeft[5][2] = [[79, 342], [142, 389], [210, 446], [276, 492], [339, 539]]
Global $BottomRight[5][2] = [[523, 537], [595, 484], [654, 440], [715, 393], [779, 344]]
Global $eThing[1] = [101]
Global $Edges[4] = [$BottomRight, $TopLeft, $BottomLeft, $TopRight]

Global $atkTroops[11][2] ;11 Slots of troops -  Name, Amount

Global $fullArmy ;Check for full army or not
;Global $deploySettings ;Method of deploy found in attack settings
Global $iChkDeploySettings[$iModeCount] ;Method of deploy found in attack settings
Global $iChkRedArea[$iModeCount], $iCmbSmartDeploy[$iModeCount], $iChkSmartAttack[$iModeCount][3], $iCmbSelectTroop[$iModeCount]

Global $troopsToBeUsed[11]
Global $useAllTroops[24] = [$eBarb, $eArch, $eGiant, $eGobl, $eWall, $eBall, $eWiza, $eHeal, $eDrag, $ePekk, $eMini, $eHogs, $eValk, $eGole, $eWitc, $eLava, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarracks[18] = [$eBarb, $eArch, $eGiant, $eGobl, $eWall, $eBall, $eWiza, $eHeal, $eDrag, $ePekk, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarbs[9] = [$eBarb, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useArchs[9] = [$eArch, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarcher[10] = [$eBarb, $eArch, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarbGob[10] = [$eBarb, $eGobl, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useArchGob[10] = [$eArch, $eGobl, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarcherGiant[11] = [$eBarb, $eArch, $eGiant, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarcherGobGiant[12] = [$eBarb, $eArch, $eGiant, $eGobl, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarcherHog[11] = [$eBarb, $eArch, $eHogs, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
Global $useBarcherMinion[11] = [$eBarb, $eArch, $eMini, $eKing, $eQueen, $eCastle, $eLSpell, $eHSpell, $eRSpell, $eJSpell, $eFSpell]
$troopsToBeUsed[0] = $useAllTroops
$troopsToBeUsed[1] = $useBarracks
$troopsToBeUsed[2] = $useBarbs
$troopsToBeUsed[3] = $useArchs
$troopsToBeUsed[4] = $useBarcher
$troopsToBeUsed[5] = $useBarbGob
$troopsToBeUsed[6] = $useArchGob
$troopsToBeUsed[7] = $useBarcherGiant
$troopsToBeUsed[8] = $useBarcherGobGiant
$troopsToBeUsed[9] = $useBarcherHog
$troopsToBeUsed[10] = $useBarcherMinion

Global $KingAttack[$iModeCount] ;King attack settings
Global $QueenAttack[$iModeCount] ;Queen attack settings
Global $A[4] = [112, 111, 116, 97]

Global $checkKPower = False ; Check for King activate power
Global $checkQPower = False ; Check for Queen activate power
Global $iActivateKQCondition
Global $delayActivateKQ ; = 9000 ;Delay before activating KQ
Global $iDropCC[$iModeCount] ; Use Clan Castle settings
Global $iChkUseCCBalanced ; Use Clan Castle Balanced settings
Global $iCmbCCDonated, $iCmbCCReceived ; Use Clan Castle Balanced ratio settings

Global $THLoc
Global $chkATH, $iChkLightSpell

Global $King, $Queen, $CC, $Barb, $Arch, $LSpell, $LSpellQ
Global $LeftTHx, $RightTHx, $BottomTHy, $TopTHy
Global $AtkTroopTH
Global $GetTHLoc
Global $iUnbreakableMode = 0
Global $iUnbreakableWait, $iUnBrkMinGold, $iUnBrkMinElixir, $iUnBrkMaxGold, $iUnBrkMaxElixir, $iUnBrkMinDark, $iUnBrkMaxDark
Global $OutOfGold = 0 ; Flag for out of gold to search for attack
Global $OutOfElixir = 0 ; Flag for out of elixir to train troops

;Boosts Settings
Global $remainingBoosts = 0 ;  remaining boost to active during session
Global $boostsEnabled = 1 ; is this function enabled

; TownHall Settings
Global $TownHallPos[2] = [-1, -1] ;Position of TownHall
Global $iTownHallLevel = 0  ; Level of user townhall
Global $Y[4] = [46, 116, 120, 116]
;Mics Setting
Global $SFPos[2] = [-1, -1] ;Position of Spell Factory

;Donate Settings
Global $aCCPos[2] = [-1, -1] ;Position of clan castle
Global $LastDonateBtn1 = -1, $LastDonateBtn2 = -1

Global $iChkRequest = 0, $sTxtRequest = ""

Global $ichkDonateAllBarbarians = 0, $ichkDonateBarbarians = 0, $sTxtDonateBarbarians = "", $sTxtBlacklistBarbarians = "", $aDonBarbarians, $aBlkBarbarians
Global $ichkDonateAllArchers = 0, $ichkDonateArchers = 0, $sTxtDonateArchers = "", $sTxtBlacklistArchers = "", $aDonArchers, $aBlkArchers
Global $ichkDonateAllGiants = 0, $ichkDonateGiants = 0, $sTxtDonateGiants = "", $sTxtBlacklistGiants = "", $aDonGiants, $aBlkGiants
Global $ichkDonateAllGoblins = 0, $ichkDonateGoblins = 0, $sTxtDonateGoblins = "", $sTxtBlacklistGoblins = "", $aDonGoblins, $aBlkGoblins
Global $ichkDonateAllWallBreakers = 0, $ichkDonateWallBreakers = 0, $sTxtDonateWallBreakers = "", $sTxtBlacklistWallBreakers = "", $aDonWallBreakers, $aBlkWallBreakers
Global $ichkDonateAllBalloons = 0, $ichkDonateBalloons = 0, $sTxtDonateBalloons = "", $sTxtBlacklistBalloons = "", $aDonBalloons, $aBlkBalloons
Global $ichkDonateAllWizards = 0, $ichkDonateWizards = 0, $sTxtDonateWizards = "", $sTxtBlacklistWizards = "", $aDonWizards, $aBlkWizards
Global $ichkDonateAllHealers = 0, $ichkDonateHealers = 0, $sTxtDonateHealers = "", $sTxtBlacklistHealers = "", $aDonHealers, $aBlkHealers
Global $ichkDonateAllDragons = 0, $ichkDonateDragons = 0, $sTxtDonateDragons = "", $sTxtBlacklistDragons = "", $aDonDragons, $aBlkDragons
Global $ichkDonateAllPekkas = 0, $ichkDonatePekkas = 0, $sTxtDonatePekkas = "", $sTxtBlacklistPekkas = "", $aDonPekkas, $aBlkPekkas
Global $ichkDonateAllMinions = 0, $ichkDonateMinions = 0, $sTxtDonateMinions = "", $sTxtBlacklistMinions = "", $aDonMinions, $aBlkMinions
Global $ichkDonateAllHogRiders = 0, $ichkDonateHogRiders = 0, $sTxtDonateHogRiders = "", $sTxtBlacklistHogRiders = "", $aDonHogRiders, $aBlkHogRiders
Global $ichkDonateAllValkyries = 0, $ichkDonateValkyries = 0, $sTxtDonateValkyries = "", $sTxtBlacklistValkyries = "", $aDonValkyries, $aBlkValkyries
Global $ichkDonateAllGolems = 0, $ichkDonateGolems = 0, $sTxtDonateGolems = "", $sTxtBlacklistGolems = "", $aDonGolems, $aBlkGolems
Global $ichkDonateAllWitches = 0, $ichkDonateWitches = 0, $sTxtDonateWitches = "", $sTxtBlacklistWitches = "", $aDonWitches, $aBlkWitches
Global $ichkDonateAllLavaHounds = 0, $ichkDonateLavaHounds = 0, $sTxtDonateLavaHounds = "", $sTxtBlacklistLavaHounds = "", $aDonLavaHounds, $aBlkLavaHounds
Global $ichkDonateAllCustom = 0, $ichkDonateCustom = 0, $sTxtDonateCustom = "", $sTxtBlacklistCustom = "", $aDonCustom, $aBlkCustom, $varDonateCustom[3][2] ;;; Custom Combination Donate by ChiefM3
Global $sTxtBlacklist = "", $aBlacklist
Global $B[6] = [116, 111, 98, 111, 116, 46]
Global $F[8] = [112, 58, 47, 47, 119, 119, 119, 46]

;Troop Settings
Global $icmbTroopComp ;Troop Composition
Global $icmbTroopCap ;Troop Capacity
Global $BarbComp = 30, $ArchComp = 60, $GoblComp = 10, $GiantComp = 4, $WallComp = 4, $WizaComp = 0, $MiniComp = 0, $HogsComp = 0
Global $DragComp = 0, $BallComp = 0, $PekkComp = 0, $HealComp = 0, $ValkComp = 0, $GoleComp = 0, $WitcComp = 0, $LavaComp = 0
Global $CurBarb = 0, $CurArch = 0, $CurGiant = 0, $CurGobl = 0, $CurWall = 0, $CurBall = 0, $CurWiza = 0, $CurHeal = 0
Global $CurMini = 0, $CurHogs = 0, $CurValk = 0, $CurGole = 0, $CurWitc = 0, $CurLava = 0, $CurDrag = 0, $CurPekk = 0
Global $T[1] = [97]
Global $ArmyComp

;Global $barrackPos[4][2] ;Positions of each barracks
Global $barrackPos[2] ;Positions of each barracks
Global $barrackTroop[5] ;Barrack troop set
Global $ArmyPos[2]
Global $barrackNum = 0
Global $barrackDarkNum = 0
;Other Settings
Global $ichkWalls
Global $icmbWalls
Global $iUseStorage
Global $itxtWallMinGold
Global $itxtWallMinElixir
Global $iVSDelay
Global $isldTrainITDelay
Global $ichkTrap, $iChkCollect, $ichkTombstones
Global $iCmbUnitDelay[$iModeCount], $iCmbWaveDelay[$iModeCount], $iChkRandomspeedatk[$iModeCount]
Global $iTimeTroops = 0
Global $iTimeGiant = 120
Global $iTimeWall = 120
Global $iTimeArch = 25
Global $iTimeGoblin = 30
Global $iTimeBarba = 20
Global $iTimeWizard = 480
Global $iChkTrophyHeroes, $iChkTrophyAtkDead
; Old upgrade buildings variables, delete after testing no harm done.
;Global $ichkUpgrade1, $ichkUpgrade2, $ichkUpgrade3, $ichkUpgrade4
;Global $itxtUpgradeX1, $itxtUpgradeY1, $itxtUpgradeX2, $itxtUpgradeY2, $itxtUpgradeX3, $itxtUpgradeY3, $itxtUpgradeX4, $itxtUpgradeY4
;Global $BuildPos1[2]
;Global $BuildPos2[2]
;Global $BuildPos3[2]
;Global $BuildPos4[2]

;General Settings
Global $botPos[2] ; Position of bot used for Hide function
Global $frmBotPosX ; Position X of the GUI
Global $frmBotPosY ; Position Y of the GUI
Global $Hide = False ; If hidden or not

Global $ichkBotStop, $icmbBotCommand, $icmbBotCond, $icmbHoursStop
Global $C[6] = [98, 117, 103, 115, 51, 46]
Global $CommandStop = -1
Global $MeetCondStop = False
Global $bTrainEnabled = True
Global $bDonationEnabled = True
Global $UseTimeStop = -1
Global $TimeToStop = -1

Global $itxtMaxTrophy ; Max trophy before drop trophy
Global $itxtdropTrophy ; trophy floor to drop to
Global $ichkAutoStart ; AutoStart mode enabled disabled
Global $ichkAutoStartDelay
Global $restarted
Global $ichkBackground ; Background mode enabled disabled
Global $collectorPos[17][2] ;Positions of each collectors
Global $D[4] = [99, 111, 109, 47]

Global $break = @ScriptDir & "\images\break.bmp"
Global $device = @ScriptDir & "\images\device.bmp"
Global $CocStopped = @ScriptDir & "\images\CocStopped.bmp"
Global $imgDivider = @ScriptDir & "\images\divider.bmp"
Global $iDividerY = 385
Global $G[3] = [104, 116, 116]
Global $resArmy = 0
Global $FirstAttack = 0
Global $CurTrophy = 0
Global $brrNum
Global $sTimer, $hour, $min, $sec, $sTimeWakeUp = 120
Global $fulltroop = 100
Global $CurCamp, $TotalCamp = 0
Global $NoLeague
Global $FirstStart = True
Global $TPaused, $BlockInputPause = 0

; Halt/Restart Mode values
Global $itxtRestartGold, $itxtRestartElixir, $itxtRestartDark


;Global $iWBMortar
;Global $iWBWizTower
;Global $iWBXbow
Global $TroopGroup[10][3] = [["Arch", 1, 1], ["Giant", 2, 5], ["Wall", 4, 2], ["Barb", 0, 1], ["Gobl", 3, 1], ["Heal", 7, 14], ["Pekk", 9, 25], ["Ball", 5, 5], ["Wiza", 6, 4], ["Drag", 8, 20]]
Global $TroopName[UBound($TroopGroup, 1)]
Global $TroopNamePosition[UBound($TroopGroup, 1)]
Global $TroopHeight[UBound($TroopGroup, 1)]
Global $TroopGroupDark[6][3] = [["Mini", 0, 2], ["Hogs", 1, 5], ["Valk", 2, 8], ["Gole", 3, 30], ["Witc", 4, 12], ["Lava", 5, 30]]
Global $TroopDarkName[UBound($TroopGroupDark, 1)]
Global $TroopDarkNamePosition[UBound($TroopGroupDark, 1)]
Global $TroopDarkHeight[UBound($TroopGroupDark, 1)]
Global $BarrackStatus[4] = [False, False, False, False]
Global $BarrackDarkStatus[2] = [False, False]
Global $listResourceLocation = ""
Global $isNormalBuild = ""
Global $isDarkBuild = ""

For $i = 0 To UBound($TroopGroup, 1) - 1
	$TroopName[$i] = $TroopGroup[$i][0]
	$TroopNamePosition[$i] = $TroopGroup[$i][1]
	$TroopHeight[$i] = $TroopGroup[$i][2]
Next
For $i = 0 To UBound($TroopGroupDark, 1) - 1
	$TroopDarkName[$i] = $TroopGroupDark[$i][0]
	$TroopDarkNamePosition[$i] = $TroopGroupDark[$i][1]
	$TroopDarkHeight[$i] = $TroopGroupDark[$i][2]
Next

;New var to search red area
Global $PixelTopLeft[0]
Global $PixelBottomLeft[0]
Global $PixelTopRight[0]
Global $PixelBottomRight[0]

Global $PixelTopLeftFurther[0]
Global $PixelBottomLeftFurther[0]
Global $PixelTopRightFurther[0]
Global $PixelBottomRightFurther[0]

Global $PixelMine[0]
Global $PixelElixir[0]
Global $PixelDarkElixir[0]
Global $PixelNearCollector[0]

Global $PixelRedArea[0]
Global $PixelRedAreaFurther[0]

Global $hBitmapFirst
Global Enum $eVectorLeftTop, $eVectorRightTop, $eVectorLeftBottom, $eVectorRightBottom

;debugging
Global $debugSearchArea = 0, $debugOcr = 0, $debugRedArea = 0, $debugSetlog = 0

;Debug CLick
Global $debugClick = 0


Global $DESTOLoc = ""

Global $dropAllOnSide = 1

; Info Profile
Global $AttacksWon = 0
Global $DefensesWon = 0
Global $TroopsDonated = 0
Global $TroopsReceived = 0

Global $LootFileName = ""

Global $lootGold
Global $lootElixir
Global $lootDarkElixir
Global $lootTrophies

; End Battle
Global $sTimeStopAtk, $sTimeStopAtk2
Global $ichkTimeStopAtk = 1
Global $ichkTimeStopAtk2 = 7
Global $ichkEndNoResources
Global $ichkTimeStopAtk, $ichkTimeStopAtk2
Global $stxtMinGoldStopAtk2 = 1000, $stxtMinElixirStopAtk2 = 1000, $stxtMinDarkElixirStopAtk2 = 50
Global $ichkEndOneStar = 0, $ichkEndTwoStars = 0

;ImprovedUpgradeBuildingHero
Global $aUpgrades[6][4] = [[-1, -1, -1, ""], [-1, -1, -1, ""], [-1, -1, -1, ""], [-1, -1, -1, ""], [-1, -1, -1, ""], [-1, -1, -1, ""]] ;Store upgrade position x&y, value, and loot type
Global $picUpgradeStatus[6], $ipicUpgradeStatus[6] ;Add indexable array variables for accessing the Upgrades GUI
Global $picUpgradeType[6], $txtUpgradeX[6], $txtUpgradeY[6], $chkbxUpgrade[6], $txtUpgradeValue[6]
Global $ichkbxUpgrade[6], $itxtUpgrMinGold, $itxtUpgrMinElixir, $txtUpgrMinDark, $itxtUpgrMinDark
Global $chkSaveWallBldr, $iSaveWallBldr
Global $pushLastModified = 0


;UpgradeTroops
Global $aLabPos[2]
Global $iChkLab, $iCmbLaboratory, $iFirstTimeLab

; Array to hold Laboratory Troop information [LocX of upper left corner of image, LocY of upper left corner of image, PageLocation, Troop "name", Icon # in DLL file]
Global Const $aLabTroops[25][5] = [ _
		[-1, -1, -1, "None", $eIcnBlank], _
		[123, 311, 0, "Barbarian", $eIcnBarbarian], _
		[123, 417, 0, "Archer", $eIcnArcher], _
		[230, 311, 0, "Giant", $eIcnGiant], _
		[230, 417, 0, "Goblin", $eIcnGoblin], _
		[336, 311, 0, "Wall Breaker", $eIcnWallBreaker], _
		[336, 417, 0, "Balloon", $eIcnBalloon], _
		[443, 311, 0, "Wizard", $eIcnWizard], _
		[443, 417, 0, "Healer", $eIcnHealer], _
		[550, 311, 0, "Dragon", $eIcnDragon], _
		[550, 417, 0, "Pekka", $eIcnPekka], _
		[657, 311, 0, "Lightning Spell", $eIcnLightSpell], _
		[657, 417, 0, "Healing Spell", $eIcnHealSpell], _
		[105, 311, 1, "Rage Spell", $eIcnRageSpell], _
		[105, 417, 1, "Jump Spell", $eIcnJumpSpell], _
		[211, 311, 1, "Freeze Spell", $eIcnFreezeSpell], _
		[211, 417, 1, "Poison Spell", $eIcnHourGlass], _
		[317, 311, 1, "Earthquake Spell", $eIcnHourGlass], _
		[317, 417, 1, "Haste Spell", $eIcnHourGlass], _
		[424, 311, 1, "Minion", $eIcnMinion], _
		[424, 417, 1, "Hog Rider", $eIcnHogRider], _
		[531, 311, 1, "Valkyrie", $eIcnValkyrie], _
		[531, 417, 1, "Golem", $eIcnGolem], _
		[637, 311, 1, "Witch", $eIcnWitch], _
		[637, 417, 1, "Lava Hound", $eIcnLavaHound]]

;deletefiles
Global $ichkDeleteLogs = 0
Global $iDeleteLogsDays = 7
Global $ichkDeleteTemp = 0
Global $iDeleteTempDays = 7
Global $ichkDeleteLoots = 0
Global $iDeleteLootsDays = 7

;dispose windows
Global $idisposewindows
Global $icmbDisposeWindowsPos

Global $iWAOffset = 0

;Planned hours
Global $iPlannedDonateHours[24]
Global $iPlannedRequestCCHours[24]
Global $iPlannedDropCCHours[24]
Global $iPlannedDonateHoursEnable
Global $iPlannedRequestCCHoursEnable
Global $iPlannedDropCCHoursEnable

; Share attack
Global $iShareAttack = 0
Global $iShareminGold
Global $iShareminElixir
Global $iSharemindark
Global $sShareMessage
Global $iShareMessageEnable = 0
Global $iShareMessageSearch = 0
Global $iShareAttackNow = 0

Global $dLastShareDateApp = _Date_Time_GetLocalTime()
Global $dLastShareDate = _DateAdd("n", -60, _Date_Time_SystemTimeToDateTimeStr($dLastShareDateApp, 1))

Global $iScreenshotType = 0
Global $ichkScreenshotHideName = 1

Global $ichkTotalCampForced = 0
Global $iValueTotalCampForced = 200

Global $iMakeScreenshotNow = False

Global $lastversion = ""
Global $lastmessage = ""
Global $ichkVersion = 1