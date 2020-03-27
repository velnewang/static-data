:: sts_rc.cmd
:: SpringToolSuite4 runcommand cmd
@echo off
call :find_dp0

:start 
echo --------start
goto end

:config
cd /d %dp0%
set ECLIPSE_INSTALL_DIR=.\sts\_current\
set PLUGIN_INI=%dp0%sts_plugin.ini
set D_USER_HOME=.\userdata_sts\d_user_home\
set D_INSTANCE_AREA=@user.home/d_osgi_instance_area/
set LOMBOK_JAR=.\lombok\_current\lombok.jar

:init_args
set LAUNCHER_BIN=%ECLIPSE_INSTALL_DIR%SpringToolSuite4.exe
set PLUGIN_INI_ARGS=-pluginCustomization %PLUGIN_INI%
:: set LAUNCHER_INI_ARGS=--launcher.ini %ECLIPSE_INSTALL_DIR%SpringToolSuite4.ini
set APPEND_VM_ARGS= ^
--launcher.appendVmargs ^
-vmargs ^
-Duser.home=%D_USER_HOME% ^
-Dosgi.user.area=@user.home/d_osgi_user_area/ ^
-Dosgi.configuration.area=@user.home/d_configuration/ ^
-Dosgi.instance.area=%D_INSTANCE_AREA% ^
-Dosgi.instance.area.default=@user.home/d_osgi_instance_area_default/ ^
-Dfile.encoding=UTF-8 ^
-Djava.io.tmpdir=%D_USER_HOME%tmpdir\
set JAVA_AGENT_ARGS=-javaagent:%LOMBOK_JAR%
:: set LAUNCHER_ARGS=%PLUGIN_INI_ARGS% %LAUNCHER_INI_ARGS% %APPEND_VM_ARGS% %JAVA_AGENT_ARGS%
set LAUNCHER_ARGS=%PLUGIN_INI_ARGS% %APPEND_VM_ARGS% %JAVA_AGENT_ARGS%
:: goto log_info

:run
cd /d %ECLIPSE_INSTALL_DIR%
start %LAUNCHER_BIN% %LAUNCHER_ARGS%

:end
echo --------end
exit /b

:log_info
echo start %LAUNCHER_BIN% %LAUNCHER_ARGS%
pause
goto end

:find_dp0
set dp0=%~dp0
exit /b
