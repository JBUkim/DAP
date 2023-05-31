@echo off
 :: BatchGotAdmin
 :-------------------------------------
 REM  --> Check for permissions
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
 if '%errorlevel%' NEQ '0' (
     echo ������ ������ ��û�ϴ� ���Դϴ�...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"
 :--------------------------------------

mkdir W1~82
mkdir W1~82\log
mkdir W1~82\good
mkdir W1~82\bad
mkdir W1~82\action
mkdir W1~82\SOLu

SET AccountScore=0
SET AccountScore3=0
SET AccountScore2=0
SET ServiceScore=0
SET ServiceScore1=0
SET ServiceScore2=0
SET ServiceScore3=0
SET PatchScore=0
SET PatchScore2=0
SET PatchScore3=0
SET LogScore=0
SET LogScore1=0
SET LogScore2=0
SET LogScore3=0
SET SecureScore=0
SET SecureScore2=0
SET SecureScore3=0

echo ============================================================������ ����� ����=========================================================== >>  W1~82\report.txt
echo 			                        [W-01] ~ [W-82]������ �׸��� �����մϴ�. >>  W1~82\report.txt
echo. >>  W1~82\report.txt
echo 			 Windows Server 2012 R2�� �������� ���۵� �ڵ��Դϴ�.���� ������ ���ؼ��� ������ �������� ���� ���� �� �ֽ��ϴ�. >>  W1~82\report.txt
echo 			 bad�׸񿡼� ��ȣ �ڿ� S�� �ٴ� �׸��� ����ڿ� �����Ͽ� ���� �����ؾ��ϴ� �׸��Դϴ�. >>  W1~82\report.txt
echo 			 bad�׸񿡼� ��ȣ �ڿ� SS�� ������ Windows Server 2012 ���� ���������� �ش��ϱ⿡ ���� �����ؾ� �ϴ� �׸��Դϴ�. >>  W1~82\report.txt

echo. >>  W1~82\report.txt

echo ===================================================================================================================================== >>  W1~82\report.txt

echo. >>  W1~82\report.txt

echo [W-01] Administrator ���� �̸� ���� >> W1~82\report.txt
echo. >>  W1~82\report.txt

net user > account.txt
net user > W1~82\log\[W-01]log.txt
net user >> W1~82\report.txt
echo. >>  W1~82\report.txt

type account.txt | find /I "Administrator" > NUL
if %errorlevel% EQU 0 (
	echo [W-01]  Administrator ������ ������ - [���] > W1~82\bad\[W-01]bad.txt 
	echo [W-01] ����- ���α׷�- ������- ��������- ���� ���� ��å - ���� ��å - ���ȿɼ� >> W1~82\action\[W-01]action.txt
	echo [W-01] ����: Administrator ���� �̸� �ٲٱ⸦ �����ϱ� ����� ���� �̸����� ���� >> W1~82\action\[W-01]action.txt
	echo [W-01]  Administrator ������ ������ - [���] >> W1~82\report.txt
	echo ����- ���α׷�- ������- ��������- ���� ���� ��å - ���� ��å - ���ȿɼ� >> W1~82\report.txt
	echo ����: Administrator ���� �̸� �ٲٱ⸦ �����ϱ� ����� ���� �̸����� ���� >> W1~82\report.txt

) else (
	echo [W-01] Administrator ������ �������� ���� - [��ȣ] > W1~82\good\[W-01]good.txt
	echo [W-01] Administrator ������ �������� ���� - [��ȣ] >> W1~82\report.txt
	SET/a AccountScore = %AccountScore%+12
	SET/a AccountScore3 = %AccountScore3%+1
)
echo. >>  W1~82\report.txt

del account.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-02] Guest ���� ���� >>  W1~82\report.txt
echo. >>  W1~82\report.txt

net user guest > W1~82\log\[W-02]log.txt
net user guest | find "Ȱ�� ����" >>  W1~82\report.txt

echo. >>  W1~82\report.txt
net user guest | find "Ȱ�� ����" | find "�ƴϿ�" > NUL
if %errorlevel% EQU  0 (
	echo [W-02] Guest ������ ��Ȱ��ȭ�Ǿ� ���� - [��ȣ] >> W1~82\good\[W-02]good.txt 
	echo [W-02] Guest ������ ��Ȱ��ȭ�Ǿ� ���� - [��ȣ] >>  W1~82\report.txt 	
	SET/a AccountScore = %AccountScore%+12
	SET/a AccountScore3 = %AccountScore3%+1	
) else (
	echo [W-02] Guest ������ Ȱ��ȭ�Ǿ� ���� -  [���] >> W1~82\bad\[W-02]bad.txt
	echo ����- ����- LUSRMGR.MSC �����- GUEST- �Ӽ� ���� ��� ���Կ� üũ >> W1~82\action\[W-02]action.txt
	echo [W-02] Guest ������ Ȱ��ȭ�Ǿ� ���� -  [���] >>  W1~82\report.txt
	echo ����- ����- LUSRMGR.MSC �����- GUEST- �Ӽ� ���� ��� ���Կ� üũ >>  W1~82\report.txt
)
echo. >>  W1~82\report.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-03] ���ʿ��� ���� ���� >>  W1~82\report.txt
echo. >>  W1~82\report.txt

net user > W1~82\log\[W-03]log.txt
net user >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-03] ���ʿ��� ������ �����ϴ� ��� - [���] > W1~82\bad\[W-03S]bad.txt
echo W1~82\log\[W-03]account.txt������ Ȯ���� "net user ������ /delete" �� �Է��Ͽ� ���ʿ��� ������ �����Ͻÿ� > W1~82\action\[W-03]action.txt
echo ����, �� ���� �κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ� �����׸� �������� 3���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-03]action.txt
echo [W-03] ���ʿ��� ������ �����ϴ� ��� - [���] >>  W1~82\report.txt
echo W1~82\log\[W-03]account.txt������ Ȯ���� "net user ������ /delete" �� �Է��Ͽ� ���ʿ��� ������ �����Ͻÿ� >>  W1~82\report.txt
echo ����, �� ���� �κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ� �����׸� �������� 12���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >>  W1~82\report.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-04] ���� ��� �Ӱ谪 ����

net accounts | find "�Ӱ谪" > W1~82\log\[W-04]log.txt
net accounts | find "�Ӱ谪" > thres.txt
net accounts | find "�Ӱ谪" >>  W1~82\report.txt
echo. >>  W1~82\report.txt

for /f "tokens=3" %%a in (thres.txt) do set thres=%%a
if %thres% leq 5 (
	echo [W-04] �Ӱ谪�� 5 ���ϰ����� �����Ǿ� ���� - [��ȣ] >> W1~82\good\[W-04]good.txt 
	echo [W-04] �Ӱ谪�� 5 ���ϰ����� �����Ǿ� ���� - [��ȣ] >>  W1~82\report.txt 
	SET/a AccountScore = %AccountScore%+12
	SET/a AccountScore3 = %AccountScore3%+1
) else (
	echo [W-04] �Ӱ谪�� 6 �̻����� �����Ǿ� ���� - [���] > W1~82\bad\[W-04]bad.txt
	echo ���� - ���� - secpol.msc - ���� ��å - ���� ��� ��å >> W1~82\action\[W-04]action.txt
	echo ���� ��� �Ӱ谪�� 5���Ϸ� ����  >> W1~82\action\[W-04]action.txt
	echo [W-04] �Ӱ谪�� 6 �̻����� �����Ǿ� ���� - [���] >>  W1~82\report.txt
	echo ���� - ���� - secpol.msc - ���� ��å - ���� ��� ��å >>  W1~82\report.txt
	echo ���� ��� �Ӱ谪�� 5���Ϸ� ����  >>  W1~82\report.txt

)
echo. >>  W1~82\report.txt

del thres.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-05] �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ���� ����

secedit /export /cfg secpol.txt   
echo f | Xcopy "secpol.txt" "W1~82\log\[W-05]log.txt"
type secpol.txt | find /I "ClearTextPassword" >>  W1~82\report.txt
echo. >>  W1~82\report.txt

type secpol.txt | find /I "ClearTextPassword" | find "0" > NUL
if %errorlevel% EQU 0 (
	echo [W-05] '��� �� ��'���� �����Ǿ� ���� - [��ȣ] > W1~82\good\[W-05]good.txt
	echo [W-05] '��� �� ��'���� �����Ǿ� ���� - [��ȣ] >>  W1~82\report.txt
	SET/a AccountScore = %AccountScore%+12
	SET/a AccountScore3 = %AccountScore3%+1
) else (
	echo [W-05] '���'���� �����Ǿ� ���� - [���] > W1~82\bad\[W-05]bad.txt
	echo ����-����-SECPOL.MSC-���� ��å-��ȣ ��å - �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ���� ���� Ȯ�� �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ������ ��� �� ������ ���� >> W1~82\action\[W-05]action.txt
	echo [W-05] '���'���� �����Ǿ� ���� - [���] >>  W1~82\report.txt
	echo ����-����-SECPOL.MSC-���� ��å-��ȣ ��å - �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ���� ���� Ȯ�� �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ������ ��� �� ������ ���� >>  W1~82\report.txt
)
echo. >>  W1~82\report.txt

del secpol.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-06] ������ �׷쿡 �ּ����� ����� ���� >>  W1~82\report.txt
echo. >>  W1~82\report.txt

net localgroup administrators | find /v "������ �� �����߽��ϴ�." > W1~82\log\[W-06]log.txt
net localgroup administrators | find /v "������ �� �����߽��ϴ�." >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-06] Administrators �׷쿡 ���ʿ��� ������ ������ �����ϴ� ��� - [���] > W1~82\bad\[W-06S]bad.txt
echo W1~82\log\[W-06]log.txt ������ Ȯ���� ������ �׷쿡 ���Ե� ���ʿ��� ������ Ȯ��, ����ڿ� �����Ͽ� >> W1~82\action\[W-06]action.txt
echo ����-����-LUSRMGR.MSC-�׷�-Administrators-�Ӽ�-Administrators �׷쿡�� ���ʿ� ���� ���� �� �׷� ���� >> W1~82\action\[W-06]action.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, �����׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-06]action.txt

echo [W-06] Administrators �׷쿡 ���ʿ��� ������ ������ �����ϴ� ��� - [���] >>  W1~82\report.txt
echo W1~82\log\[W-06]log.txt ������ Ȯ���� ������ �׷쿡 ���Ե� ���ʿ��� ������ Ȯ��, ����ڿ� �����Ͽ� >>  W1~82\report.txt
echo ����-����-LUSRMGR.MSC-�׷�-Administrators-�Ӽ�-Administrators �׷쿡�� ���ʿ� ���� ���� �� �׷� ���� >>  W1~82\report.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, �����׸� �������� ���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >>  W1~82\report.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-07] ���� ���� �� ����� �׷� ���� >>  W1~82\report.txt
echo. >>  W1~82\report.txt

net share > W1~82\log\[W-07]log.txt
net share >>  W1~82\report.txt
echo. >>  W1~82\report.txt

echo [W-07] �Ϲ� ���� ���丮�� ���� ���ѿ� Everyone ������ �ִ� ��� - [���] > W1~82\bad\[W-07S]bad.txt
echo W1~82\log\[W-07]log.txt ���Ͽ��� ������ ����ǰ� �ִ� ���� ����� Ȯ���� ��� ���ѿ��� Everyone���� �� ������ ���� >> W1~82\action\[W-07]action.txt
echo ����-����-FSMGMT.MSC-����-��� ���ѿ��� Everyone���� �� ������ �����ϰ� ������ �ʿ��� ������ ������ ���� �߰� >> W1~82\action\[W-07]action.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-07]action.txt

echo [W-07] �Ϲ� ���� ���丮�� ���� ���ѿ� Everyone ������ �ִ� ��� - [���] >>  W1~82\report.txt
echo W1~82\log\[W-07]log.txt ���Ͽ��� ������ ����ǰ� �ִ� ���� ����� Ȯ���� ��� ���ѿ��� Everyone���� �� ������ ���� >>  W1~82\report.txt
echo ����-����-FSMGMT.MSC-����-��� ���ѿ��� Everyone���� �� ������ �����ϰ� ������ �ʿ��� ������ ������ ���� �߰� >>  W1~82\report.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >>  W1~82\report.txt

echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-08] �ϵ��ũ �⺻ ���� ���� >> W1~82\report.txt
SET/a W8S=0

net share > log.txt
net share | find /v "������ �� �����߽��ϴ�." > W1~82\log\[W-08]log.txt

type log.txt | findstr /I "C$ D$ IPC$" > NUL
if %errorlevel% EQU 0 (
	echo [W-08] �ϵ��ũ �⺻ ���� ���ŵ� - [��ȣ] > W1~82\good\[W-08]good.txt
	echo [W-08] �ϵ��ũ �⺻ ���� ���ŵ� - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+6
	SET/a W8S=1
) else (
	echo [W-08] �ϵ��ũ �⺻ ���� ���� �� �� - [���] > W1~82\bad\[W-08]bad.txt
	echo [W-08] �ϵ��ũ �⺻ ���� ���� �� �� - [���] >> W1~82\report.txt
	echo [W-08]log.txt ������ Ȯ���ϰ� �ϵ��ũ �⺻ ������ �����Ͻÿ� > W1~82\action\[W-08]action.txt
	echo ����-����-FSMGMT.MSC-����-�⺻��������-���콺 ��Ŭ��-���� ���� >>  W1~82\action\[W-08]action.txt
	echo [W-08]log.txt ������ Ȯ���ϰ� �ϵ��ũ �⺻ ������ �����Ͻÿ� >> W1~82\report.txt
	echo ����-����-FSMGMT.MSC-����-�⺻��������-���콺 ��Ŭ��-���� ���� >> W1~82\report.txt
)

del log.txt

reg query "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" | findstr /I "autoshare" >> W1~82\log\[W-08-2]log.txt
reg query "HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters" | findstr /I "autoshare" >> reg.txt

type reg.txt | find "0x0"
if %errorlevel% EQU 0 (
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0 - [��ȣ] > W1~82\good\[W-08]good.txt 
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0 - [��ȣ]  >> W1~82\report.txt 
	SET/a ServiceScore = %ServiceScore%+6
	SET/a W8S=1
) else (
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0 �ƴ� - [���] >> W1~82\bad\[W-08]bad.txt
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0 �ƴ� - [���] >> W1~82\report.txt
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0���� �����Ͻʽÿ� >>  W1~82\action\[W-08]action.txt
	echo [W-08] �ϵ��ũ �⺻ ���� ������Ʈ�� �� 0���� �����Ͻʽÿ� >> W1~82\report.txt
	echo ����-����-REGEDIT >>  W1~82\action\[W-08]action.txt
	echo ����-����-REGEDIT>> W1~82\report.txt
	echo �Ʒ� ������Ʈ�� ���� 0���� ���� (Ű���� ���� ��� ���� ����) >> W1~82\action\[W-08]action.txt
	echo �Ʒ� ������Ʈ�� ���� 0���� ���� (Ű���� ���� ��� ���� ����) >> W1~82\report.txt
	echo ��HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer�� >> W1~82\action\[W-08]action.txt
	echo ��HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer�� >> W1~82\report.txt
)
if %W8S% EQU 1 (
	SET/a ServiceScore3 = %ServiceScore3%+1
)

del reg.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-09] ���ʿ��� ���� ����  >> W1~82\report.txt
net start > W1~82\log\[W-09]log.txt

echo [W-09] �Ϲ������� ���ʿ��� ����(�Ʒ� ��� ����)�� ���� ���� ��� - [���] > W1~82\bad\[W-09S]bad.txt
echo W1~82\log\[W-09]log.txt ������ Ȯ���ϰ� ���ʿ��� ���� �����ϼ���(���̵� �� ǥ ����) >> W1~82\action\[W-09]action.txt
echo ����-����-SERVICES.MSC-���ش� ���񽺡�����-�Ӽ�, ���� ����-������, ���� ����-������������ ���ʿ��� ���� ���� >> W1~82\action\[W-09]action.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-09]action.txt

echo [W-09] �Ϲ������� ���ʿ��� ����(�Ʒ� ��� ����)�� ���� ���� ��� - [���] >> W1~82\report.txt
echo W1~82\log\[W-09]log.txt ������ Ȯ���ϰ� ���ʿ��� ���� �����ϼ���(���̵� �� ǥ ����) >> W1~82\report.txt
echo ����-����-SERVICES.MSC-���ش� ���񽺡�����-�Ӽ�, ���� ����-������, ���� ����-������������ ���ʿ��� ���� ���� >> W1~82\report.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-10] IIS���� ���� ���� >> W1~82\report.txt


net start > W1~82\log\[W-10]log.txt

type W1~82\log\[W-10]log.txt | find /i "IIS ADMIN Service" >nul 2>&1
if %errorlevel% EQU 0 (
  echo [W-10] IIS���񽺰� �ʿ����� ������ ����ϴ� ��� - [���] > W1~82\bad\[W-10]bad.txt
  echo ����ڿ� ���� �� IIS ���񽺰� ���ʿ��� �� >> W1~82\action\[W-10]action.txt
  echo ����-����-SERVICE.MSC-IISADMIN-�Ӽ�-���� ������ ��� ���� ���� �� ������ IIS ���� ���� >> W1~82\action\[W-10]action.txt

  echo [W-10] IIS���񽺰� �ʿ����� ������ ����ϴ� ��� - [���]  >> W1~82\report.txt
  echo ����ڿ� ���� �� IIS ���񽺰� ���ʿ��� ��  >> W1~82\report.txt
  echo ����-����-SERVICE.MSC-IISADMIN-�Ӽ�-���� ������ ��� ���� ���� �� ������ IIS ���� ����  >> W1~82\report.txt
) else (
  echo [W-10] IIS���񽺰� �ʿ����� �ʾ� �̿����� �ʴ� ��� - [��ȣ] > W1~82\good\[W-10]good.txt 
  echo [W-10] IIS���񽺰� �ʿ����� �ʾ� �̿����� �ʴ� ��� - [��ȣ]  >> W1~82\report.txt
  SET/a ServiceScore = %ServiceScore%+12
  SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-11] ���丮 ������ ���� >> W1~82\report.txt

type C:\inetpub\wwwroot\web.config | find /i "directoryBrowse" > W1~82\log\[W-11]log.txt
type C:\inetpub\wwwroot\web.config | find /i "directoryBrowse" > inform.txt

type inform.txt | find /i "false"
if %errorlevel% equ 0 (
	echo [W-11] ���丮 �˻��� ��� �� ������ �����Ǿ� ���� - [��ȣ] > W1~82\good\[W-11]good.txt
	echo [W-11] ���丮 �˻��� ��� �� ������ �����Ǿ� ���� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
) else (
	echo [W-11] ���丮 �˻��� ������� �����Ǿ� ���� - [���] > W1~82\bad\[W-11]bad.txt
	echo [W-11] ������-��������-���ͳ��������� IIS����-�ش� �� ����Ʈ-IIS-���丮 �˻� ����-��� ���� ���� >> W1~82\action\[W-11]action.txt
	echo [W-11] ���丮 �˻��� ������� �����Ǿ� ���� - [���]  >> W1~82\report.txt
	echo [W-11] ������-��������-���ͳ��������� IIS����-�ش� �� ����Ʈ-IIS-���丮 �˻� ����-��� ���� ����  >> W1~82\report.txt
)

del  inform.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-12] IIS CGI ���� ����(scripts ���翩��) >> W1~82\report.txt
SET/a W12S=0

dir C:\inetpub /b > W1~82\log\[W-12]log.txt

type W1~82\log\[W-12]log.txt | find /I "scripts" > nul 
if %errorlevel% EQU 0 (
	echo [W-12] �ش� ���丮�� scripts ������ �����Ұ�� ������ - [���] > W1~82\bad\[W-12]bad.txt 
	echo [W-12] �ش� ���丮�� scripts ������ �����Ұ�� ������ - [���]  >> W1~82\report.txt 

) else (
	echo [W-12] scripts ������ �������� �ʴ� ��� - [��ȣ] >> W1~82\good\[W-12]good.txt
	echo [W-12] scripts ������ �������� �ʴ� ��� - [��ȣ] >> W1~82\report.txt 
      SET/a ServiceScore = %ServiceScore%+12
	SET/a W12S=1
	goto W12END
)

echo [W-12-1] IIS CGI ���� ���� >> W1~82\report.txt
 
icacls C:\inetpub\scripts | findstr /i "EVERYONE" > W1~82\log\[W-12]log.txt
type W1~82\log\[W-12]log.txt | findstr /i "W M F"
if %errorlevel% EQU 0 (
	echo [W-12] �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο��Ǿ� �ִ� ��� - [���] >> W1~82\bad\[W-12]bad.txt 
	echo [W-12] Ž����-�ش� ���丮-�Ӽ�-����-Everyone�� ��� ����, ���� ����, ���� ���� ���� >> W1~82\action\[W-12]action.txt
	echo [W-12] �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο��Ǿ� �ִ� ��� - [���]  >> W1~82\report.txt 
	echo [W-12] Ž����-�ش� ���丮-�Ӽ�-����-Everyone�� ��� ����, ���� ����, ���� ���� ����  >> W1~82\report.txt 

) else (
	echo [W-12-1] �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ���� ��� - [��ȣ] >> W1~82\good\[W-12]good.txt
	echo [W-12-1] �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ���� ��� - [��ȣ] >> W1~82\report.txt 
      SET/a ServiceScore = %ServiceScore%+6
	SET/a W12S=1

)
:W12END
if %W12S% EQU 1 (
	SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-13] IIS ���� ���丮 ���� ����

type C:\Windows\System32\inetsrv\config\applicationHost.config  > W1~82\log\[W-13]log.txt
type W1~82\log\[W-13]log.txt | find /I "enableParentPaths" | find /i "false" > log.txt
if errorlevel 0 goto W13B
if not errorlevel 0 goto W13G

:W13B
	echo [W-13] ���� ���丮 ���� ����� �������� ���� ��� - [���] > W1~82\bad\[W-13]bad.txt 
	echo [W-13] ������-��������-���ͳ� ��������(IIS) ������-�ش� ������Ʈ-IIS-ASP ����-�θ��� ��� �׸�-False ���� >> W1~82\action\[W-13]action.txt
	echo [W-13] ���� ���丮 ���� ����� �������� ���� ��� - [���] >> W1~82\report.txt 
	echo [W-13] ������-��������-���ͳ� ��������(IIS) ������-�ش� ������Ʈ-IIS-ASP ����-�θ��� ��� �׸�-False ���� >> W1~82\report.txt
	goto W13

:W13G
	echo [W-13] ���� ���丮 ���� ����� ������ ��� - [��ȣ] > W1~82\good\[W-13]good.txt
	echo [W-13] ���� ���丮 ���� ����� ������ ��� - [��ȣ]  >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
	goto W13

:W13
del log.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-14] IIS ���ʿ��� ���� ���� >> W1~82\report.txt

echo [W-14] �ش� �� ����Ʈ�� IIS Samples, IIS Help ������丮�� �����ϴ� ��� >> W1~82\bad\[W-14SS]bad.txt
echo [W-14] IIS 7.0(Windows 2008) �̻� ���� �ش���� ���� >> W1~82\action\[W-14SS]action.txt
echo [W-14] Windows 2000, 2003�� ��� Sample ���丮 Ȯ�� �� ���� >> W1~82\action\[W-14SS]action.txt
echo [W-14] ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-14SS]action.txt

echo [W-14] �ش� �� ����Ʈ�� IIS Samples, IIS Help ������丮�� �����ϴ� ���  >> W1~82\report.txt
echo [W-14] IIS 7.0(Windows 2008) �̻� ���� �ش���� ���� >> W1~82\report.txt
echo [W-14] Windows 2000, 2003�� ��� Sample ���丮 Ȯ�� �� ����  >> W1~82\report.txt
echo [W-14] ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-15] �� ���μ��� ���� ���� >> W1~82\report.txt

echo [W-15] �� ���μ����� ������ ������ �ο��� �������� �����ǰ� �ִ� ��� >> W1~82\bad\[W-15S]bad.txt
echo [W-15] ���� - ������ - �������� - ��ǻ�� ���� - ���� ����� �� �׷� - ����� ���� - nobody ���� �߰�  >> W1~82\action\[W-15S]action.txt
echo [W-15] ���� - ������ - �������� - ���� ���� ��å - ����� ���� �Ҵ� ����, " ���� �α׿�" �� "nobody" ���� �߰� >> W1~82\action\[W-15S]action.txt
echo [W-15] ���� - ���� - SERVICES.MSC - IIS Admin Service - �Ӽ� - [�α׿�] ���� ���� ������ nobody ���� �� �н����� �Է� >> W1~82\action\[W-15S]action.txt
echo [W-15] ���� - ���α׷� - ������ Ž���� - IIS�� ��ġ�� ���� �Ӽ� - [����] �ǿ��� nobody ������ �߰��ϰ� ��� ���� üũ >> W1~82\action\[W-15S]action.txt

echo. >> W1~82\action\[W-15S]action.txt
echo [W-15] "������Ʈ �������" - Ȩ ���丮 - �������α׷� ��ȣ(iis ���μ��� ���� ���� ) >> W1~82\action\[W-15S]action.txt
echo [W-15] ���� ,���� ,���� �� �������� �Ǿ��ִ� ��� >> W1~82\action\[W-15S]action.txt
echo [W-15] IIS ���μ����� �ý��� ������ ������ �ǹǷ� ��Ŀ�� IIS ���μ����� ������ ȹ���ϸ� �����ڿ� ���ϴ� ������ ���� �� �����Ƿ� ����  >> W1~82\action\[W-15S]action.txt
echo [W-15] ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-15S]action.txt

echo [W-15] �� ���μ����� ������ ������ �ο��� �������� �����ǰ� �ִ� ��� >> W1~82\report.txt
echo [W-15] ���� - ������ - �������� - ��ǻ�� ���� - ���� ����� �� �׷� - ����� ���� - nobody ���� �߰�  >> W1~82\report.txt
echo [W-15] ���� - ������ - �������� - ���� ���� ��å - ����� ���� �Ҵ� ����, " ���� �α׿�" �� "nobody" ���� �߰� >> W1~82\report.txt
echo [W-15] ���� - ���� - SERVICES.MSC - IIS Admin Service - �Ӽ� - [�α׿�] ���� ���� ������ nobody ���� �� �н����� �Է� >> W1~82\report.txt
echo [W-15] ���� - ���α׷� - ������ Ž���� - IIS�� ��ġ�� ���� �Ӽ� - [����] �ǿ��� nobody ������ �߰��ϰ� ��� ���� üũ >> W1~82\report.txt

echo. >> W1~82\report.txt
echo [W-15] "������Ʈ �������" - Ȩ ���丮 - �������α׷� ��ȣ(iis ���μ��� ���� ���� ) >> W1~82\report.txt
echo [W-15] ���� ,���� ,���� �� �������� �Ǿ��ִ� ��� >> W1~82\report.txt
echo [W-15] IIS ���μ����� �ý��� ������ ������ �ǹǷ� ��Ŀ�� IIS ���μ����� ������ ȹ���ϸ� �����ڿ� ���ϴ� ������ ���� �� �����Ƿ� ���� >> W1~82\report.txt
echo [W-15] ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-16] IIS ��ũ ������ >> W1~82\report.txt

set file=C:\inetpub\wwwroot

for /f "tokens=*" %%a in ('dir %file% /S /B') do echo %%a >> W1~82\log\[W-16]log.txt
WHERE /r C:\inetpub\wwwroot *.htm *.url *.html 
if %errorlevel% EQU 0 (
	echo [W-16] �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ����� - [���] >> W1~82\bad\[W-16]bad.txt
	echo [W-16] ��ϵ� �� ����Ʈ�� Ȩ ���丮�� �ִ� �ɺ��� ��ũ, aliases, �ٷΰ��� ������ �����Ͻʽÿ�. >> W1~82\action\[W-16]action.txt
	echo ������-�ý��� �� ����-��������-IIS������-�ش� ������Ʈ-�⺻ ����-"���� ���"���� Ȩ ���丮 ��ġ Ȯ�� >> W1~82\action\[W-16]action.txt
	echo ���� ��ο� �Էµ� Ȩ ���丮�� �̵��Ͽ� �ٷΰ��� ������ ���� >> W1~82\action\[W-16]action.txt

	echo [W-16] �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ����� - [���] >> W1~82\report.txt
	echo [W-16] ��ϵ� �� ����Ʈ�� Ȩ ���丮�� �ִ� �ɺ��� ��ũ, aliases, �ٷΰ��� ������ �����Ͻʽÿ�. >> W1~82\report.txt
	echo ������-�ý��� �� ����-��������-IIS������-�ش� ������Ʈ-�⺻ ����-"���� ���"���� Ȩ ���丮 ��ġ Ȯ�� >> W1~82\report.txt
	echo ���� ��ο� �Էµ� Ȩ ���丮�� �̵��Ͽ� �ٷΰ��� ������ ���� >> W1~82\report.txt

)	else (
	echo [W-16] �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ������� ���� - [��ȣ] >> W1~82\good\[W-16]good.txt
	echo [W-16] �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ������� ���� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-17] IIS ���� ���ε� �� �ٿ�ε� ���� >> W1~82\report.txt 

type C:\inetpub\wwwroot\web.config | findstr /I "maxAllowedContentLength" >> W1~82\log\[W-17]log.txt
type C:\Windows\System32\inetsrv\config\applicationHost.config | findstr /I "bufferingLimit maxRequestEntityAllowed" >> W1~82\log\[W-17]log.txt
echo [W-17] �� ���μ����� ���� �ڿ��� �������� �ʴ� ��� (���ε� �� �ٿ�ε� �뷮 �� ����) - [���] >> W1~82\bad\[W-17S]bad.txt
echo [W-17] �� ���μ����� ���� �ڿ��� �������� �ʴ� ��� (���ε� �� �ٿ�ε� �뷮 �� ����) - [���] >> W1~82\report.txt

echo IIS 7���� �̻󿡼��� �⺻������ �������뷮 31457280byte(30MB), �ٿ�ε� 4194304byte(4MB), ���ε� 200000byte(0.2MB)�� �����ϰ� �ֽ��ϴ�. >> W1~82\action\[W-17]action.txt
echo ��ϵ� �� ����Ʈ�� ��Ʈ ���丮�� �ִ� web.config ���� �� security �Ʒ��� ���� �׸��� �߰��ϼ���. >> W1~82\action\[W-17]action.txt
echo ^<requestFiltering^> >> W1~82\action\[W-17]action.txt
echo     ^<requestLimits maxAllowedContentLength="�������뷮" /^> >> W1~82\action\[W-17]action.txt
echo ^<requestFiltering^> >>W1~82\action\[W-17]action.txt
echo - >> W1~82\action\[W-17]action.txt
echo %systemroot% \system32\inetsrv\config\applicationHost.config ���� �� ^<asp/^>�� ^<asp^>���̿� ���� �׸� �߰� >> W1~82\report.txt

echo ^<limits bufferingLimit="���ϴٿ�ε�뷮" maxRequestEntityAllowed="���Ͼ��ε�뷮" /^> >> W1~82\report.txt
echo IIS 7���� �̻󿡼��� �⺻������ �������뷮 31457280byte(30MB), �ٿ�ε� 4194304byte(4MB), ���ε� 200000byte(0.2MB)�� �����ϰ� �ֽ��ϴ�. >> W1~82\report.txt
echo ��ϵ� �� ����Ʈ�� ��Ʈ ���丮�� �ִ� web.config ���� �� security �Ʒ��� ���� �׸��� �߰��ϼ���. >> W1~82\report.txt
echo ^<requestFiltering^> >> W1~82\report.txt
echo     ^<requestLimits maxAllowedContentLength="�������뷮" /^> >> W1~82\report.txt
echo ^<requestFiltering^> >> W1~82\report.txt
echo - >> W1~82\report.txt
echo %systemroot% \system32\inetsrv\config\applicationHost.config ���� �� ^<asp/^>�� ^<asp^>���̿� ���� �׸� �߰� >> W1~82\report.txt
echo ^<limits bufferingLimit="���ϴٿ�ε�뷮" maxRequestEntityAllowed="���Ͼ��ε�뷮" /^> >> W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-18] IIS DB ���� ����� ���� >> W1~82\report.txt
SET/a W18S=0

type C:\inetpub\wwwroot\web.config | findstr /I "path="*."" >> pathSite.txt
type C:\inetpub\wwwroot\web.config | findstr /I "fileExtension" >> filterSite.txt
type C:\Windows\System32\inetsrv\config\applicationHost.config | findstr /I "path="*."" >> pathServer.txt
type C:\Windows\System32\inetsrv\config\applicationHost.config | findstr /I "fileExtension" >> filterServer.txt
type pathSite.txt | findstr /I "*.asa *.asax" >> W1~82\log\[W-18]Sitepathlog.txt
type filterSite.txt | findstr /I "asa asax" >> W1~82\log\[W-18]Sitefilterlog.txt
type pathServer.txt | findstr /I "*.asa *.asax" >> W1~82\log\[W-18]Serverpathlog.txt
type filterServer.txt | findstr /I "asa asax" >> W1~82\log\[W-18]Serverfilterlog.txt

type pathServer.txt | findstr /I "*.asa *.asax"
if not %errorlevel% EQU 0 (
	echo [W-18] ���� "ó�������"�� ��� �׸� asa, asax�� ��ϵǾ� ���� �ʽ��ϴ�. - [��ȣ] >> W1~82\good\[W-18]good.txt
	echo [W-18] ���� "ó�������"�� ��� �׸� asa, asax�� ��ϵǾ� ���� �ʽ��ϴ�. - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+3
	SET/a W18S=1

)	else (
	echo [W-18] ���� "ó�������"�� ����׸� asa, asax�� ��ϵǾ� �ֽ��ϴ�. - [���] >> W1~82\bad\[W-18]bad.txt
	echo [W-18] IIS������-�ش缭��- IIS-"ó���� ����"����-��� �׸� *.asa �� *.asax�� �����ϼ���. >> W1~82\action\[W-18]action.txt
	echo [W-18] ���� "ó�������"�� ����׸� asa, asax�� ��ϵǾ� �ֽ��ϴ�. - [���] >> W1~82\report.txt
	echo [W-18] IIS������-�ش缭��- IIS-"ó���� ����"����-��� �׸� *.asa �� *.asax�� �����ϼ���. >> W1~82\report.txt
)

type filterServer.txt | find /I "true" | findstr /I "asa asax"
if not %errorlevel% EQU 0 (
	echo [W-18] ���� "��û ���͸�"�� asa, asax Ȯ���ڰ� false�� �����Ǿ� �ֽ��ϴ�. - [��ȣ] >> W1~82\good\[W-18]good.txt
	echo [W-18] ���� "��û ���͸�"�� asa, asax Ȯ���ڰ� false�� �����Ǿ� �ֽ��ϴ�. - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+3
	SET/a W18S=1
)	else (
	echo [W-18] ���� "��û ���͸�"�� asa, asax Ȯ���ڰ� true�� �����Ǿ� �ֽ��ϴ�. - [���] >> W1~82\bad\[W-18]bad.txt
	echo [W-18] IIS������-�ش缭��-IIS-"��û ���͸�"����-asa �� asax Ȯ���ڸ� false�� �����ϼ���. >> W1~82\action\[W-18]action.txt
	echo [W-18] ���� "��û ���͸�"�� asa, asax Ȯ���ڰ� true�� �����Ǿ� �ֽ��ϴ�. - [���] >> W1~82\report.txt
	echo [W-18] IIS������-�ش缭��-IIS-"��û ���͸�"����-asa �� asax Ȯ���ڸ� false�� �����ϼ���. >> W1~82\report.txt

)

type pathSite.txt | findstr /I "*.asa *.asax"
if not %errorlevel% EQU 0 (
	echo [W-18] ����Ʈ "ó�������"�� ��� �׸� asa, asax�� ��ϵǾ� ���� �ʽ��ϴ�. - [��ȣ] >> W1~82\good\[W-18]good.txt
	echo [W-18] ����Ʈ "ó�������"�� ��� �׸� asa, asax�� ��ϵǾ� ���� �ʽ��ϴ�. - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+3
	SET/a W18S=1
)	else (
	echo [W-18] ����Ʈ "ó�������"�� ����׸� asa, asax�� ��ϵǾ� �ֽ��ϴ�. - [���] >> W1~82\bad\[W-18]bad.txt
	echo [W-18] IIS������-�ش� �� ����Ʈ- IIS-"ó���� ����"����-��� �׸� *.asa �� *.asax�� �����ϼ���. >> W1~82\action\[W-18]action.txt
	echo [W-18] ����Ʈ "ó�������"�� ����׸� asa, asax�� ��ϵǾ� �ֽ��ϴ�. - [���] >> W1~82\report.txt
	echo [W-18] IIS������-�ش� �� ����Ʈ- IIS-"ó���� ����"����-��� �׸� *.asa �� *.asax�� �����ϼ���. >> W1~82\report.txt

)

type filterSite.txt | find /I "true" | findstr /I "asa asax"
if not %errorlevel% EQU 0 (
	echo [W-18] ����Ʈ "��û ���͸�"�� asa, asax Ȯ���ڰ� false�� �����Ǿ� �ֽ��ϴ�. - [��ȣ] >> W1~82\good\[W-18]good.txt
	echo [W-18] ����Ʈ "��û ���͸�"�� asa, asax Ȯ���ڰ� false�� �����Ǿ� �ֽ��ϴ�. - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+3
	SET/a W18S=1
)	else (
	echo [W-18] ����Ʈ "��û ���͸�"�� asa, asax Ȯ���ڰ� true�� �����Ǿ� �ֽ��ϴ�. - [���] >> W1~82\bad\[W-18]bad.txt
	echo [W-18] IIS������-�ش� �� ����Ʈ-IIS-"��û ���͸�"����-asa �� asax Ȯ���ڸ� false�� �����ϼ���. >> W1~82\action\[W-18]action.txt
	echo [W-18] ����Ʈ "��û ���͸�"�� asa, asax Ȯ���ڰ� true�� �����Ǿ� �ֽ��ϴ�. - [���] >> W1~82\report.txt
	echo [W-18] IIS������-�ش� �� ����Ʈ-IIS-"��û ���͸�"����-asa �� asax Ȯ���ڸ� false�� �����ϼ���. >> W1~82\report.txt

)
if %W18S% EQU 1 (
	SET/a ServiceScore3 = %ServiceScore3%+1
)

del pathSite.txt
del filterSite.txt
del pathServer.txt
del filterServer.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-19] IIS ���� ���丮 ���� >> W1~82\report.txt

echo [W-19] �ش� �� ����Ʈ�� IIS Admin, IIS Adminpwd ���� ���丮�� �����ϴ� ��� - [���] > W1~82\bad\[W-19SS]bad.txt
echo [W-19] �ش� �� ����Ʈ�� IIS Admin, IIS Adminpwd ���� ���丮�� �����ϴ� ��� - [���] >> W1~82\report.txt

echo Windows 2003(6.0) �̻� ���� �ش� ���� ���� >> W1~82\action\[W-19]action.txt
echo Windows 2000(5.0) >> W1~82\action\[W-19]action.txt
echo ����-����-INETMGR �Է�-�� ����Ʈ- IISAdmin, IISAdminpwd ����-���� >> W1~82\action\[W-19]action.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 12���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-19]action.txt


echo Windows 2003(6.0) �̻� ���� �ش� ���� ���� >> W1~82\report.txt
echo Windows 2000(5.0) >> W1~82\report.txt
echo ����-����-INETMGR �Է�-�� ����Ʈ- IISAdmin, IISAdminpwd ����-���� >> W1~82\report.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 3���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-20] IIS ������ ���� ACL ���� >> W1~82\report.txt

icacls "C:\inetpub\wwwroot" >> W1~82\log\[W-20]log.txt

icacls "C:\inetpub\wwwroot" | findstr /I "Everyone" > NUL
if %errorlevel% EQU 0 (
  echo [W-20] Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ ���� - [���] > W1~82\bad\[W-20]bad.txt
  echo ����-����-INETMGR �Է�-����Ʈ Ŭ��-�ش� ������Ʈ-�⺻ ����- Ȩ ���丮 ���� ��� Ȯ�� >> W1~82\action\[W-20]action.txt
  echo Ž���⸦ �̿��Ͽ� Ȩ ���丮�� ��� ����-[����]�ǿ��� Everyone ���� Ȯ�� >> W1~82\action\[W-20]action.txt
  echo ���ʿ��� Everyone ������ �����Ͻʽÿ�. >> W1~82\action\[W-20]action.txt

  echo [W-20] Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ ���� - [���] >> W1~82\report.txt
  echo ����-����-INETMGR �Է�-����Ʈ Ŭ��-�ش� ������Ʈ-�⺻ ����- Ȩ ���丮 ���� ��� Ȯ�� >> W1~82\report.txt
  echo Ž���⸦ �̿��Ͽ� Ȩ ���丮�� ��� ����-[����]�ǿ��� Everyone ���� Ȯ�� >> W1~82\report.txt
  echo ���ʿ��� Everyone ������ �����Ͻʽÿ�. >> W1~82\report.txt
)	else (
	echo [W-20] Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� ���� - [��ȣ] > W1~82\good\[W-20]good.txt
	echo [W-20] Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� ���� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-21] IIS Exec ���ɾ� �� ȣ�� ���� >> W1~82\report.txt

dir C:\Windows\System32\inetsrv /b > W1~82\log\[W-21]log.txt
dir C:\Windows\System32\inetsrv /b > list.txt

type list.txt | findstr /i /l ".htr .IDC .stm .shtm .shtml .printer .htw .ida .idq htr.dll idc.dll stm.dll shtm.dll shtml.dll printer.dll htw.dll ida.dll idq.dll" > W1~82\log\[W-21]detectlog.txt
type list.txt | findstr /i /l ".htr .IDC .stm .shtm .shtml .printer .htw .ida .idq htr.dll idc.dll stm.dll shtm.dll shtml.dll printer.dll htw.dll ida.dll idq.dll" > list2.txt
if errorlevel 1 goto W21G
if not errorlevel 1 goto W21B


:W21B
	echo [W-21] htr IDC stm shtm shtml printer htw ida idq�� ������ log���� Ȯ�� - [���] >> W1~82\bad\[W-21]bad.txt 
	echo [W-21] ���� - ���� - INETMGR - ������Ʈ - �ش� ������Ʈ - ó���� ���� ���� >> W1~82\action\[W-21]action.txt
	echo [W-21] ����� ���� ���� (htr idc stm shtm shtml printer htw ida idq) >> W1~82\action\[W-21]action.txt
	echo [W-21] htr IDC stm shtm shtml printer htw ida idq�� ������ log���� Ȯ�� - [���] >> W1~82\report.txt 
	echo [W-21] ���� - ���� - INETMGR - ������Ʈ - �ش� ������Ʈ - ó���� ���� ���� >> W1~82\report.txt
	echo [W-21] ����� ���� ���� (htr idc stm shtm shtml printer htw ida idq) >> W1~82\report.txt
	goto W21

:W21G
	echo [W-21] htr IDC stm shtm shtml printer htw ida idq�� ������������  - [��ȣ] >> W1~82\good\[W-21]good.txt
	echo [W-21] htr IDC stm shtm shtml printer htw ida idq�� ������������  - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
	goto W21

:W21
del list.txt
del list2.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-22] IIS Exec ���ɾ� �� ȣ�� ����(������Ʈ���� ���� ����) >> W1~82\report.txt
SET/a W22S=0

reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters /s | find /v "����" > W1~82\log\[W-22]log.txt
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters /s | find /v "����" > reg.txt
type reg.txt | find /I "SSIEnableCmdDirective" > NUL

if %errorlevel% EQU 1 (
	echo [W-22] ������Ʈ������ �������� �ʰų� IIS 6.0������ ��� - [��ȣ] >> W1~82\good\[W-22]good.txt
	echo [W-22] ������Ʈ������ �������� �ʰų� IIS 6.0������ ��� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
	SET/a W22S=1
	goto W22
) else (
	echo [W-22] �ش� ������Ʈ������ ������ - [���] >> W1~82\bad\[W-22]bad.txt
	echo [W-22] �ش� ������Ʈ������ ������ - [���] >> W1~82\report.txt
	goto W22-1
)

:W22-1
echo [W-22] IIS Exec ���ɾ� �� ȣ�� ���� >> W1~82\report.txt

type reg.txt | find /I "SSIEnableCmdDirective" > ssl.txt

type ssl.txt | find "0x1"
if %errorlevel% EQU 1 (
	echo [W-22-1] ������Ʈ������ 0��  - [��ȣ] > W1~82\good\[W-22]good.txt
	echo [W-22-1] ������Ʈ������ 0��  - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
	SET/a W22S=1
	del  W1~82\bad\[W-22]bad.txt
) else (
	echo [W-22-1] �ش� ������Ʈ������ 1�� [���] >> W1~82\bad\[W-22]bad.txt
	echo ���� - ���� - REGEDIT - HKLM\SYSTEM\CurrentControlSet\Services\W32VC\Parameters �˻� > W1~82\action\[W-22]action.txt
	echo DWORD - SSIEnableCmdDirective ���� ã�� ���� 0���� �Է� >> W1~82\action\[W-22]action.txt

	echo [W-22-1] �ش� ������Ʈ������ 1�� [���] >> W1~82\report.txt
	echo ���� - ���� - REGEDIT - HKLM\SYSTEM\CurrentControlSet\Services\W32VC\Parameters �˻� >> W1~82\report.txt
	echo DWORD - SSIEnableCmdDirective ���� ã�� ���� 0���� �Է� >> W1~82\report.txt

)

:W22
if %W22S% EQU 1 (
	SET/a ServiceScore3 = %ServiceScore3%+1
)

del reg.txt
del ssl.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-23] IIS WebDAV ��Ȱ��ȭ >> W1~82\report.txt

type C:\Windows\System32\inetsrv\config\applicationHost.config > log.txt
type C:\Windows\System32\inetsrv\config\applicationHost.config > W1~82\log\[W-23]log.txt

type log.txt | findstr /I "webdav.dll" | find "true"
if errorlevel 1 goto W23G
if not errorlevel 1 goto W23B

:W23B
echo [W-23] WebDav�� ������ - [���] >> W1~82\bad\[W-23]bad.txt  
echo ���ͳ� ���� ����(IIS) ������ - ���� ���� - IIS - ISAPI �� CGI ���� ����, WebDAV ��뿩�� Ȯ�� (������ ��� ���) >> W1~82\action\[W-23]action.txt
echo ���ͳ� ���� ����(IIS) ������ - ���� ���� > IIS - "ISAPI �� CGI ����" ���� WebDAV �׸� ���� - �۾����� �����ϰų�, ���� - "Ȯ�� ��� ���� ���" üũ ����  >> W1~82\action\[W-23]action.txt
echo [W-23] WebDav�� ������ - [���] >> W1~82\report.txt  
echo ���ͳ� ���� ����(IIS) ������ - ���� ���� - IIS - ISAPI �� CGI ���� ����, WebDAV ��뿩�� Ȯ�� (������ ��� ���) >> W1~82\report.txt
echo ���ͳ� ���� ����(IIS) ������ - ���� ���� > IIS - "ISAPI �� CGI ����" ���� WebDAV �׸� ���� - �۾����� �����ϰų�, ���� - "Ȯ�� ��� ���� ���" üũ ����  >> W1~82\report.txt

goto W23

:W23G
echo [W-23] WebDav�� ������������  - [��ȣ] >> W1~82\good\[W-23]good.txt
echo [W-23] WebDav�� ������������  - [��ȣ] >> W1~82\report.txt
SET/a ServiceScore = %ServiceScore%+12
SET/a ServiceScore3 = %ServiceScore3%+1

goto W23


:W23
del log.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-24] NetBIOS ���ε� ���� ���� ���� >> W1~82\report.txt

wmic nicconfig where "TcpipNetbiosOptions<>null and ServiceName<>'VMnetAdapter'" get Description, TcpipNetbiosOptions > W1~82\log\[W-24]log.txt
wmic nicconfig where "TcpipNetbiosOptions<>null and ServiceName<>'VMnetAdapter'" get Description, TcpipNetbiosOptions > netb.txt

type netb.txt | findstr /I "0" > NUL
if %errorlevel% EQU 0 (
	 echo [w-24]  TCP/IP�� NetBIOS ���� ���ε��� ���� �Ǿ� ���� [��ȣ] > W1~82\good\[W-24]good.txt
	 echo [w-24]  TCP/IP�� NetBIOS ���� ���ε��� ���� �Ǿ� ���� [��ȣ] >> W1~82\report.txt
	 SET/a ServiceScore = %ServiceScore%+12
	 SET/a ServiceScore3 = %ServiceScore3%+1
) else (
	echo [W-24] TCP/IP�� NetBIOS ���� ���ε��� ���� �Ǿ����� ���� [���] > W1~82\bad\[W-24]bad.txt 
	echo [W-24] ���� - ���� - ncpa.cpl - ���� ���� ���� - �Ӽ� - TCP/IP - [�Ϲ�] �ǿ��� [����] Ŭ�� - [WINS] �ǿ��� TCP/IP���� "NetBIOS ��� �� ��" �Ǵ�, "NetBIOS over TCP/IP ��� �� ��" ���� >> W1~82\action\[W-24]action.txt

	echo [W-24] TCP/IP�� NetBIOS ���� ���ε��� ���� �Ǿ����� ���� [���] >> W1~82\report.txt 
	echo [W-24] ���� - ���� - ncpa.cpl - ���� ���� ���� - �Ӽ� - TCP/IP - [�Ϲ�] �ǿ��� [����] Ŭ�� - [WINS] �ǿ��� TCP/IP���� "NetBIOS ��� �� ��" �Ǵ�, "NetBIOS over TCP/IP ��� �� ��" ���� >> W1~82\report.txt

)

del netb.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-25] FTP ���� ���� ���� >> W1~82\report.txt

net start | find "Microsoft FTP Service" >  W1~82\log\[W-25]log.txt

net start | find "Microsoft FTP Service"
if %errorlevel% EQU 0 (
	echo [W-25] FTP ���񽺸� ����ϴ� ��� - [���] > W1~82\bad\[W-25]bad.txt
  echo FTP ���񽺰� ���ʿ��� ��� FTP���� ��� ���� >> W1~82\action\[W-25]action.txt
	echo ���� - ���� - SERVICES.MSC - FTP Publishing Service - �Ӽ� - [�Ϲ�] �ǿ��� "���� ����" ��� �� �� ���� ������ ��, FTP ���� ���� >> W1~82\action\[W-25]action.txt

	echo [W-25] FTP ���񽺸� ����ϴ� ��� - [���] >> W1~82\report.txt
  echo FTP ���񽺰� ���ʿ��� ��� FTP���� ��� ���� >> W1~82\report.txt
	echo ���� - ���� - SERVICES.MSC - FTP Publishing Service - �Ӽ� - [�Ϲ�] �ǿ��� "���� ����" ��� �� �� ���� ������ ��, FTP ���� ���� >> W1~82\report.txt

) else (
	echo [W-25] FTP ���񽺸� ������� �ʴ� ��� - [��ȣ] > W1~82\good\[W-25]good.txt
	echo [W-25] FTP ���񽺸� ������� �ʴ� ��� - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+12
	SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-26] FTP ���丮 ���ٱ��� ���� >> W1~82\report.txt
 
icacls C:\inetpub\ftproot > W1~82\log\[W-26]log.txt

icacls C:\inetpub\ftproot | findstr /i "EVERYONE"
if %errorlevel% EQU 0 (
	echo [W-26] FTP Ȩ ���丮�� Everyone ������ �ִ� ��� - [���] >> W1~82\bad\[W-26]bad.txt
	echo [W-26] ���ͳ� ���� ���� IIS ���� - FTP ����Ʈ - �ش� FTP ����Ʈ - �Ӽ� - [Ȩ ���丮] �ǿ��� FTP Ȩ ���丮 Ȯ�� >> W1~82\action\[W-26]action.txt 
	echo [W-26] Ž���� - Ȩ ���丮 - �Ӽ� - [����] �ǿ��� Everyone ���� ���� >> W1~82\action\[W-26]action.txt

	echo [W-26] FTP Ȩ ���丮�� Everyone ������ �ִ� ��� - [���] >> W1~82\report.txt
	echo [W-26] ���ͳ� ���� ���� IIS ���� - FTP ����Ʈ - �ش� FTP ����Ʈ - �Ӽ� - [Ȩ ���丮] �ǿ��� FTP Ȩ ���丮 Ȯ�� >> W1~82\report.txt 
	echo [W-26] Ž���� - Ȩ ���丮 - �Ӽ� - [����] �ǿ��� Everyone ���� ���� >> W1~82\report.txt

) else (
	echo [W-26] ��ȣ FTP Ȩ ���丮�� Everyone ������ ���� ��� - [��ȣ] >> W1~82\good\[W-26]good.txt
	echo [W-26] ��ȣ FTP Ȩ ���丮�� Everyone ������ ���� ��� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
)

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-27] Anonymous FTP ���� >> W1~82\report.txt

type C:\Windows\System32\inetsrv\config\applicationHost.config | find "anonymousAuthentication enabled" > W1~82\log\[W-27]log.txt
type C:\Windows\System32\inetsrv\config\applicationHost.config | find "anonymousAuthentication enabled" > log.txt

type log.txt | find "true" 
if %errorlevel% EQU 0 (
	echo [W-27] FTP �͸� ��� ���� - [���] > W1~82\bad\[W-27]bad.txt
	echo ������-��������-���ͳ� ���� ���� IIS ����-�ش� ������Ʈ-���콺 ��Ŭ��-FTP �Խ� �߰� > W1~82\action\[W-27]action.txt
	echo ���� ���� �������� ���� ȭ���� �͸� üũ �ڽ� ���� >> W1~82\action\[W-27]action.txt

	echo [W-27] FTP �͸� ��� ���� - [���] >> W1~82\report.txt
	echo ������-��������-���ͳ� ���� ���� IIS ����-�ش� ������Ʈ-���콺 ��Ŭ��-FTP �Խ� �߰� >> W1~82\report.txt
	echo ���� ���� �������� ���� ȭ���� �͸� üũ �ڽ� ���� >> W1~82\report.txt

) else (
	echo [W-27] FTP �͸� ����� ��� ���� - [��ȣ] > W1~82\good\[W-27]good.txt
	echo [W-27] FTP �͸� ����� ��� ���� - [��ȣ] >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
)

del log.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-28] FTP ���� ���� ���� >> W1~82\report.txt

type C:\Windows\System32\inetsrv\config\applicationHost.config | find /I "add ipAddress" > W1~82\log\[W-28]log.txt

echo [W-28] FTP ���� ���� ���� Ȯ�� - [���] > W1~82\bad\[W-28S]bad.txt
echo W1~82\log\[W-28]log.txt ������ Ȯ���ϰ� ����ڿ� �����Ͽ� ���ʿ��� �ּ��� ������ ���� �Ͻʽÿ�. >> W1~82\action\[W-28]action.txt
echo ��ġ ��� : ������-��������-���ͳ� ���� ����(IIS)����-�ش� ������Ʈ-FTP IPv4�ּ� �� ������ ���� >> W1~82\action\[W-28]action.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 3���� �ο��� �ֽʽÿ�. >> W1~82\action\[W-28]action.txt

echo [W-28] FTP ���� ���� ���� Ȯ�� - [���] >> W1~82\report.txt
echo W1~82\log\[W-28]log.txt ������ Ȯ���ϰ� ����ڿ� �����Ͽ� ���ʿ��� �ּ��� ������ ���� �Ͻʽÿ�. >> W1~82\report.txt
echo ��ġ ��� : ������-��������-���ͳ� ���� ����(IIS)����-�ش� ������Ʈ-FTP IPv4�ּ� �� ������ ���� >> W1~82\report.txt
echo ����, �� ���˺κп��� ��ȣ�ϴٰ� �Ǵ��� �ȴٸ�, ���� �׸� �������� 3���� �ο��� �ֽʽÿ�. >>  W1~82\report.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-29] DNS Zone Transfer ���� >> W1~82\report.txt
SET/a W29S=0

net start > W1~82\log\[W-29]log.txt
net start > log.txt

type log.txt | find "DNS Server"
if %errorlevel% EQU 1 (
	echo [W-29] DNS���񽺸� ������� �ʴ� ��� - [��ȣ] >> W1~82\good\[W-29]good.txt
	echo [W-29] DNS���񽺸� ������� �ʴ� ��� - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+6
	SET/a W29S=1
) else (
	echo [W-29] DNS���񽺸� ����ϴ� ��� - [���] >> W1~82\bad\[W-29]bad.txt
	echo [W-29] DNS���񽺸� �ߴ��ϼ���. >> W1~82\action\[W-29]action.txt

	echo [W-29] DNS���񽺸� ����ϴ� ��� - [���] >> W1~82\report.txt
	echo [W-29] DNS���񽺸� �ߴ��ϼ���. >> W1~82\report.txt

)

reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s >> W1~82\log\[W-29]log.txt
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find /I "SecureSecondaries" >> reg.txt

type reg.txt | findstr /I "0x1 0x2"
if %errorlevel% EQU 1 (
	echo [W-29] ���� ���� ����� ���� �ʴ� ��� - [��ȣ] >> W1~82\good\[W-29]good.txt 
	echo [W-29] ���� ���� ����� ���� �ʴ� ��� - [��ȣ] >> W1~82\report.txt
	SET/a ServiceScore = %ServiceScore%+6
	SET/a W29S=1
) else (
	echo [W-29] ���� ���� ����� �ϴ� ��� - [���] >> W1~82\bad\[W-29]bad.txt
	echo [W-29] W1~82\log\[W-29]log.txt ������ Ȯ���Ͽ� 'SecureSecondaries' ������Ʈ������ 0x0�̰ų� 0x3�� �ƴ� �׸��� ���� ���� ���� ���� >> W1~82\action\[W-29]action.txt
	echo [W-29] ����-����-DNSMGMT.MSC-�� ��ȸ ����-�ش� ����-�Ӽ�-���� ���� >> W1~82\action\[W-29]action.txt
	echo [W-29] ������ �����θ��� ������ ������ ���� IP �߰� >> W1~82\action\[W-29]action.txt

	echo [W-29] ���� ���� ����� �ϴ� ��� - [���] >> W1~82\report.txt
	echo [W-29] W1~82\log\[W-29]log.txt ������ Ȯ���Ͽ� 'SecureSecondaries' ������Ʈ������ 0x0�̰ų� 0x3�� �ƴ� �׸��� ���� ���� ���� ���� >> W1~82\report.txt
	echo [W-29] ����-����-DNSMGMT.MSC-�� ��ȸ ����-�ش� ����-�Ӽ�-���� ���� >> W1~82\report.txt
	echo [W-29] ������ �����θ��� ������ ������ ���� IP �߰� >> W1~82\report.txt
)
if %W29S% EQU 1 (
	SET/a ServiceScore3 = %ServiceScore3%+1
)


del log.txt
del reg.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt

echo [W-30] RDS (Remote Data Services)���� >> W1~82\report.txt

reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters" /s >> W1~82\log\[W-30]log.txt
reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters" /s >> log.txt

type log.txt | findstr "ADCLaunch" 
if errorlevel EQU 0 (
	echo [W-30] RDS(Remote Data Services) ���ŵ� (2008 �̻� ��ȣ) >> W1~82\good\[W-30SS]good.txt
	echo [W-30] RDS(Remote Data Services) ���ŵ� (2008 �̻� ��ȣ) >> W1~82\report.txt
      SET/a ServiceScore = %ServiceScore%+12
      SET/a ServiceScore3 = %ServiceScore3%+1
	goto W30
) else (
	echo [W-30] RDS(Remote Data Services) ���ŵ� (2008 �̸� ���) >> W1~82\bad\[W-30SS]bad.txt
	echo ����-����-inetmgr-������Ʈ ���� �� ������ ���丮���� msadc���� >> W1~82\action\[W-30SS]action.txt
	echo ������ ������Ʈ�� Ű/���丮 ����>> W1~82\action\[W-30SS]action.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\RDSServer.DataFactory >> W1~82\action\[W-30SS]action.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\AdvancedDataFactory >> W1~82\action\[W-30SS]action.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\VbBusObj.VbBusObjCls >> W1~82\action\[W-30SS]action.txt

	echo [W-30] RDS(Remote Data Services) ���ŵ� (2008 �̸� ���) >> W1~82\report.txt
	echo ����-����-inetmgr-������Ʈ ���� �� ������ ���丮���� msadc���� >> W1~82\report.txt
	echo ������ ������Ʈ�� Ű/���丮 ���� >> W1~82\report.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\RDSServer.DataFactory >> W1~82\report.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\AdvancedDataFactory >> W1~82\report.txt
	echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch\VbBusObj.VbBusObjCls >> W1~82\report.txt

	goto W30
)

:W30
del log.txt

echo. >> W1~82\report.txt
echo ===================================================================================================================================== >>  W1~82\report.txt
echo. >> W1~82\report.txt


echo %AccountScore%
echo %AccountScore2%
echo %AccountScore3%
echo %AccountScore% > W1~82\SOLu\AScore.txt
echo %AccountScore2% > W1~82\SOLu\AScore2.txt
echo %AccountScore3% > W1~82\SOLu\AScore3.txt
echo %ServiceScore%
echo %ServiceScore1%
echo %ServiceScore2%
echo %ServiceScore3%
echo %ServiceScore% > W1~82\SOLu\SScore.txt
echo %ServiceScore1% > W1~82\SOLu\SSCore1.txt
echo %ServiceScore2% > W1~82\SOLu\SScore2.txt
echo %ServiceScore3% > W1~82\SOLu\SScore3.txt
echo %PatchScore%
echo %PatchScore2%
echo %PatchScore3%
echo %PatchScore% > W1~82\SOLu\PScore.txt
echo %PatchScore2% > W1~82\SOLu\PScore2.txt
echo %PatchScore3% > W1~82\SOLu\PScore3.txt
echo %LogScore%
echo %LogScore1%
echo %LogScore2%
echo %LogScore3%
echo %LogScore% > W1~82\SOLu\LScore.txt
echo %LogScore1% > W1~82\SOLu\LScore1.txt
echo %LogScore2% > W1~82\SOLu\LScore2.txt
echo %LogScore3% > W1~82\SOLu\LScore3.txt
echo %SecureScore%
echo %SecureScore2%
echo %SecureScore3%
echo %SecureScore% > W1~82\SOLu\SeScore.txt
echo %SecureScore2% > W1~82\SOLu\SeScore2.txt
echo %SecureScore3% > W1~82\SOLu\SeScore3.txt
pause




