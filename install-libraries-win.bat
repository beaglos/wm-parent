@echo off
rem This script is intended for wm version 10.5 - if this changes please update jar-filenames as well!
rem This script requires Maven excecutable to be in PATH or MVN_BIN set to executable.

SET MVN_BIN=mvn
SET MVN_CMD=call %MVN_BIN%

SET DEFAULT_WEBMETHODS_HOME=C:\SoftwareAG
if DEFINED WEBMETHODS_HOME ( 
	SET SAG_BASE=%WEBMETHODS_HOME%
) else (
	SET SAG_BASE=%DEFAULT_WEBMETHODS_HOME%
)
SET LIB_COMMON=%SAG_BASE%\common\lib
SET LIB_WSSTACK=%SAG_BASE%\WS-Stack\lib
SET LIB_IS=%SAG_BASE%\IntegrationServer\lib

if not exist %LIB_COMMON% (
	echo ERROR: Could not find common/lib directory in %SAG_BASE%.
	echo Maybe you must set WEBMETHODS_HOME to point to the correct base directory other than C:\SoftwareAG.	
	goto:EOF
)

rem import SAG jars into local m2 repository
SET VER_SAG=10.5
SET MVN_CMD_IMPORT=%MVN_CMD% install:install-file -Dpackaging=jar -DgeneratePom=true

%MVN_CMD_IMPORT% -DgroupId=com.entrust -DartifactId=toolkit -Dversion=8.0.33-1242 -Dfile=%LIB_COMMON%\ext\enttoolkit.jar

%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods -DartifactId=wm-g11nutils 	-Dversion=%VER_SAG% -Dfile=%LIB_COMMON%\wm-g11nutils.jar
%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods -DartifactId=wm-isclient 	-Dversion=%VER_SAG% -Dfile=%LIB_COMMON%\wm-isclient.jar
%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods -DartifactId=wm-isserver 	-Dversion=%VER_SAG% -Dfile=%SAG_BASE%\IntegrationServer\lib\wm-isserver.jar
%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods -DartifactId=deployer-api 	-Dversion=%VER_SAG% -Dfile=%LIB_WSSTACK%\deployer-api-%VER_SAG%.0.0.jar

%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods.wsstack -DartifactId=client-api 		-Dversion=%VER_SAG% -Dfile=%LIB_WSSTACK%\client-api-%VER_SAG%.0.0.jar
%MVN_CMD_IMPORT% -DgroupId=com.softwareag.webmethods.wsstack -DartifactId=wsstack-commons 	-Dversion=%VER_SAG% -Dfile=%LIB_WSSTACK%\wsstack-commons-%VER_SAG%.0.0.jar

