<#
Note on Popup parameters:
The first param is the message contained within the box,
the second is the timer, the third is the Popup
window title, and the fourth parameter is the style of Popup.
#>
    $wshell = New-Object -ComObject Wscript.Shell

    #First Popup 
    $wshell.Popup("This computer is scheduled for shutdown",10,"Save Data",0x0)

    #Second Popup (this is the one that waits for 5 minutes, or whatever value you need)
    $PopUp = $wshell.Popup("5 minutes to shutdown",300,"Please save your work.",1)

    #If second popup is not clicked, or user clicks OK, wait 30 seconds and shut down computer
    if ( $PopUp -like 1 -or $PopUp -like -1)
    {

        $xCmdString = {sleep 30}

        Invoke-Command $xCmdString

        $Computer = $env:COMPUTERNAME

        Stop-Computer -ComputerName "$Computer" -Force
    }
    #If user clicks Cancel, stop the shutdown process
    else 
    {$wshell.Popup("Computer shutdown has been canceled.",10,"Shutdown Canceled",0x0)}