@echo off
set HERE=%~dp0
if #%HERE:~-1%# == #\# set HERE=%HERE:~0,-1%
goto :StartCode
'================================================================================================================
'
' ©2024 SIEMENS EDA. All Rights Reserved.
'
' This software or file (the "Material") contains trade secrets or otherwise confidential information owned by
' Siemens Industry Software Inc. or its affiliates (collectively, "SISW"), or SISW's licensors. Access to and use
' of this information is strictly limited as set forth in one or more applicable agreement(s) with SISW. This
' Material may not be copied, distributed, or otherwise disclosed without the express written permission of SISW,
' and may not be used in any way not expressly authorized by SISW.
'
' Unless otherwise agreed in writing, SISW has no obligation to support or otherwise maintain this Material.
' No representation or other affirmation of fact herein shall be deemed to be a warranty or give rise to any
' liability of SISW whatsoever.
'
' SISW reserves the right to make changes in specifications and other information contained herein without prior
' notice, and the reader should, in all cases, consult SISW to determine whether any changes have been made.
'
' SISW MAKES NO WARRANTY OF ANY KIND WITH REGARD TO THIS MATERIAL INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
' WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF INTELLECTUAL PROPERTY.
' SISW SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, CONSEQUENTIAL OR PUNITIVE DAMAGES, LOST DATA OR
' PROFITS, EVEN IF SUCH DAMAGES WERE FORESEEABLE, ARISING OUT OF OR RELATED TO THIS PUBLICATION OR THE
' INFORMATION CONTAINED IN IT, EVEN IF SISW HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
'
' TRADEMARKS: The trademarks, logos, and service marks (collectively, "Marks") used herein are the property of
' Siemens AG, SISW, or their affiliates (collectively, "Siemens") or other parties. No one is permitted to use
' these Marks without the prior written consent of Siemens or the owner of the Marks, as applicable. The use
' herein of third party Marks is not an attempt to indicate Siemens as a source of a product, but is intended to
' indicate a product from, or associated with, a particular third party. A list of Siemens' Marks may be viewed
' at: www.plm.automation.siemens.com/global/en/legal/trademarks.html
'
'================================================================================================================
'
' File:    Setup.bat
'
' Author:  Don Waldoch
'
' Revision History:
'
'   1.00  06/13/24  DTW  Initial Release.
'
'================================================================================================================
:StartCode

call :setenv EDATK      "%HERE%"
call :setenv EDATK_ZIP  "%HERE%\7z2406-extra"
call :setenv EDATK_NODE "%HERE%\node-v20.14.0-win-x64"
call :setenv EDATK_PERL "%HERE%\Perl-5.36.3-win-x64"

where git.exe > NUL 2>&1
if %errorlevel%==0 goto :gitinstalled
   REM 7za.exe --help
   echo.
   echo.Installing Portable Git...
   %EDATK_ZIP%\7za.exe x -t7z -y -o"%HERE%" "%HERE%\PortableGit-2.45.2-win-x64.7z"

:gitinstalled
   FOR /F "delims=" %%i IN ('where git.exe') DO set gitpath=%%~dpi
   call :dirname "%gitpath%" gitpath
   call :dirname "%gitpath%" gitpath
   call :setenv EDATK_GIT "%gitpath%"

echo.
echo.Installing Portable Node.js...
%EDATK_ZIP%\7za.exe x -t7z -y -o"%HERE%" "%HERE%\node-v20.14.0-win-x64.7z"

echo.
echo.Installing Portable Perl...
%EDATK_ZIP%\7za.exe x -t7z -y -o"%HERE%" "%HERE%\Perl-5.36.3-win-x64.7z"

echo.
echo.   EDATK      = %EDATK%
echo.   EDATK_ZIP  = %EDATK_ZIP%
echo.   EDATK_GIT  = %EDATK_GIT%
echo.   EDATK_NODE = %EDATK_NODE%
echo.   EDATK_PERL = %EDATK_PERL%
echo.

pause
exit

REM #########################################################################
:dirname
    setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
    SET _dir=%~dp1
    SET _dir=%_dir:~0,-1%
    endlocal & set %2=%_dir%
goto :eof
REM #########################################################################
:setenv
   SETLOCAL ENABLEDELAYEDEXPANSION
   C:\Windows\System32\setx.exe %1 %~2 > NUL 2>&1
   SETLOCAL DISABLEDELAYEDEXPANSION
   goto :eof
REM #########################################################################
