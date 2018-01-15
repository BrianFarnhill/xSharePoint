function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserEnabling = $true,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserRendering = $true,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionTimeout = 20000,

        [Parameter()]
        [System.UInt32]
        $DefaultDataConnectionTimeout = 10000,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionResponseSize = 1500,

        [Parameter()]
        [System.Boolean]
        $RequireSslForDataConnections = $true,

        [Parameter()]
        [System.Boolean]
        $AllowEmbeddedSqlForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUdcAuthenticationForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormCrossDomainDataConnections = $false,

        [Parameter()]
        [System.UInt16]
        $MaxPostbacksPerSession = 75,

        [Parameter()]
        [System.UInt16]
        $MaxUserActionsPerPostback = 200,

        [Parameter()]
        [System.UInt16]
        $ActiveSessionsTimeout = 1440,

        [Parameter()]
        [System.UInt16]
        $MaxSizeOfUserFormState = 4096,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $InstallAccount
    )

    Write-Verbose -Message "Getting InfoPath Forms Service Configuration"

    $result = Invoke-SPDSCCommand -Credential $InstallAccount `
                                  -Arguments $PSBoundParameters `
                                  -ScriptBlock {
        $params = $args[0]

        $config = Get-SPInfoPathFormsService
        $nullReturn = @{
            AllowUserFormBrowserEnabling = $params.AllowUserFormBrowserEnabling
            AllowUserFormBrowserRendering = $params.AllowUserFormBrowserRendering
            MaxDataConnectionTimeout = $params.MaxDataConnectionTimeout
            DefaultDataConnectionTimeout = $params.DefaultDataConnectionTimeout
            MaxDataConnectionResponseSize = $params.MaxDataConnectionResponseSize
            RequireSslForDataConnections = $params.RequireSslForDataConnections
            AllowEmbeddedSqlForDataConnections = $params.AllowEmbeddedSqlForDataConnections
            AllowUdcAuthenticationForDataConnections = $params.AllowUdcAuthenticationForDataConnections
            AllowUserFormCrossDomainDataConnections = $params.AllowUserFormCrossDomainDataConnections
            MaxPostbacksPerSession = $params.MaxPostbacksPerSession
            MaxUserActionsPerPostback = $params.MaxUserActionsPerPostback
            ActiveSessionsTimeout = $params.ActiveSessionsTimeout
            MaxSizeOfUserFormState = ($params.MaxSizeOfUserFormState / 1024)
            Ensure = "Absent"
            InstallAccount = $params.InstallAccount
        }
        if ($null -eq $config)
        {
            return $nullReturn
        }

        return @{
            AllowUserFormBrowserEnabling = $config.AllowUserFormBrowserEnabling
            AllowUserFormBrowserRendering = $config.AllowUserFormBrowserRendering
            MaxDataConnectionTimeout = $config.MaxDataConnectionTimeout
            DefaultDataConnectionTimeout = $config.DefaultDataConnectionTimeout
            MaxDataConnectionResponseSize = $config.MaxDataConnectionResponseSize
            RequireSslForDataConnections = $config.RequireSslForDataConnections
            AllowEmbeddedSqlForDataConnections = $config.AllowEmbeddedSqlForDataConnections
            AllowUdcAuthenticationForDataConnections = $config.AllowUdcAuthenticationForDataConnections
            AllowUserFormCrossDomainDataConnections = $config.AllowUserFormCrossDomainDataConnections
            MaxPostbacksPerSession = $config.MaxPostbacksPerSession
            MaxUserActionsPerPostback = $config.MaxUserActionsPerPostback
            ActiveSessionsTimeout = $config.ActiveSessionsTimeout
            MaxSizeOfUserFormState = ($config.MaxSizeOfUserFormState / 1024)
            Ensure = "Present"
            InstallAccount = $params.InstallAccount
        }
    }
    return $result
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserEnabling = $true,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserRendering = $true,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionTimeout = 20000,

        [Parameter()]
        [System.UInt32]
        $DefaultDataConnectionTimeout = 10000,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionResponseSize = 1500,

        [Parameter()]
        [System.Boolean]
        $RequireSslForDataConnections = $true,

        [Parameter()]
        [System.Boolean]
        $AllowEmbeddedSqlForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUdcAuthenticationForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormCrossDomainDataConnections = $false,

        [Parameter()]
        [System.UInt16]
        $MaxPostbacksPerSession = 75,

        [Parameter()]
        [System.UInt16]
        $MaxUserActionsPerPostback = 200,

        [Parameter()]
        [System.UInt16]
        $ActiveSessionsTimeout = 1440,

        [Parameter()]
        [System.UInt16]
        $MaxSizeOfUserFormState = 4096,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $InstallAccount
    )

    Write-Verbose -Message "Setting InfoPath Forms Service Configuration"

    if($Ensure -eq "Absent")
    {
        throw "This ressource cannot undo InfoPath Forms Service Configuration changes. `
        Please set Ensure to Present or ommit the resource"
    }

    Invoke-SPDSCCommand -Credential $InstallAccount `
                        -Arguments $PSBoundParameters `
                        -ScriptBlock {
        $params = $args[0]
        $config = Get-SPInfoPathFormsService
        $config.AllowUserFormBrowserEnabling = $params.AllowUserFormBrowserEnabling
        $config.AllowUserFormBrowserRendering = $params.AllowUserFormBrowserRendering
        $config.MaxDataConnectionTimeout = $params.MaxDataConnectionTimeout
        $config.DefaultDataConnectionTimeout = $params.DefaultDataConnectionTimeout
        $config.MaxDataConnectionResponseSize = $params.MaxDataConnectionResponseSize
        $config.RequireSslForDataConnections = $params.RequireSslForDataConnections
        $config.AllowEmbeddedSqlForDataConnections = $params.AllowEmbeddedSqlForDataConnections
        $config.AllowUdcAuthenticationForDataConnections = $params.AllowUdcAuthenticationForDataConnections
        $config.AllowUserFormCrossDomainDataConnections = $params.AllowUserFormCrossDomainDataConnections
        $config.MaxPostbacksPerSession = $params.MaxPostbacksPerSession
        $config.MaxUserActionsPerPostback = $params.MaxUserActionsPerPostback
        $config.ActiveSessionsTimeout = $params.ActiveSessionsTimeout
        $config.MaxSizeOfUserFormState = ($config.MaxSizeOfUserFormState * 1024)

        $config.Update()
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserEnabling = $true,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormBrowserRendering = $true,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionTimeout = 20000,

        [Parameter()]
        [System.UInt32]
        $DefaultDataConnectionTimeout = 10000,

        [Parameter()]
        [System.UInt32]
        $MaxDataConnectionResponseSize = 1500,

        [Parameter()]
        [System.Boolean]
        $RequireSslForDataConnections = $true,

        [Parameter()]
        [System.Boolean]
        $AllowEmbeddedSqlForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUdcAuthenticationForDataConnections = $false,

        [Parameter()]
        [System.Boolean]
        $AllowUserFormCrossDomainDataConnections = $false,

        [Parameter()]
        [System.UInt16]
        $MaxPostbacksPerSession = 75,

        [Parameter()]
        [System.UInt16]
        $MaxUserActionsPerPostback = 200,

        [Parameter()]
        [System.UInt16]
        $ActiveSessionsTimeout = 1440,

        [Parameter()]
        [System.UInt16]
        $MaxSizeOfUserFormState = 4096,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $InstallAccount
    )

    Write-Verbose -Message "Testing the InfoPath Form Services Configuration"

    $PSBoundParameters.Ensure = $Ensure

    $CurrentValues = Get-TargetResource @PSBoundParameters

    return Test-SPDscParameterState -CurrentValues $CurrentValues `
                                    -DesiredValues $PSBoundParameters `
                                    -ValuesToCheck @("Ensure")
}

Export-ModuleMember -Function *-TargetResource