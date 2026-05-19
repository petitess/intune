#DeviceManagementConfiguration.ReadWrite.All
#List all policies with a specific template family
$uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies?`$filter=templateReference/templateFamily eq 'endpointSecurityApplicationControl'"
(Invoke-MgGraphRequest -Method GET -Uri $uri).value |
Select-Object @{ Label = "Template Family"; Expression = { $_.templateReference.templateId } }, name, id
#Get a specific policy with settings
$uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies/b1eb66d3-d933-47ca-94b0-fe33b41c533e?`$expand=settings"
(Invoke-MgGraphRequest -Method GET -Uri $uri) | ConvertTo-Json -Depth 100
#List all policies with a specific template family and get the next page of results
$uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies?`$filter=templateReference/templateFamily eq 'endpointSecurityApplicationControl'"
$all = @()
do {
    $resp = Invoke-MgGraphRequest -Method GET -Uri $uri
    $all += $resp.value
    $uri = $resp.'@odata.nextLink'
} while ($uri)

$all | Select-Object name, id, @{
    Name       = "Template"
    Expression = { $_.templateReference.templateId }
}
#Create a new policy with settings
$xmlContent = Get-Content -Path "C:\Users\Karol\Desktop\AppControl.xml"
$body = @{
    "name"              = "test-app-control"
    "description"       = ""
    "settings"          = @(
        @{
            "settingInstance" = @{
                "@odata.type"                      = "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance"
                "choiceSettingValue"               = @{
                    "@odata.type"                   = "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue"
                    "children"                      = @(
                        @{
                            "@odata.type"         = "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance"
                            "simpleSettingValue"  = @{
                                "@odata.type" = "#microsoft.graph.deviceManagementConfigurationStringSettingValue"
                                "value"       = "$xmlContent"
                            }
                            "settingDefinitionId" = "device_vendor_msft_policy_config_applicationcontrolv2_xmlupload"
                        }
                    )
                    "settingValueTemplateReference" = @{
                        "settingValueTemplateId" = "8e9847a2-8a1b-4168-a5fc-4a99cd8cd480"
                    }
                    "value"                         = "device_vendor_msft_policy_config_applicationcontrolv2_buildoptions_upload_xml_selected"
                }
                "settingDefinitionId"              = "device_vendor_msft_policy_config_applicationcontrolv2_buildoptions"
                "settingInstanceTemplateReference" = @{
                    "settingInstanceTemplateId" = "abc5b8cd-63a0-4a1c-a34d-da84d9a93f62"
                }
            }
        }
    )
    "roleScopeTagIds"   = @(
        "0"
    )
    "platforms"         = "windows10"
    "technologies"      = "mdm"
    "templateReference" = @{
        "templateId" = "d3849ba8-bf95-467c-9640-aa2334eae9e3_1"
    }
}

$uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"
(Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body)

$xml = @"
<?xml version="1.0" encoding="utf-8"?>
<SiPolicy xmlns="urn:schemas-microsoft-com:sipolicy" PolicyType="Supplemental Policy">
  <VersionEx>10.0.0.0</VersionEx>
  <PlatformID>{2E07F7E4-194C-4D20-B7C9-6F44A6C5A234}</PlatformID>
  <Rules>
    <Rule>
      <Option>Enabled:Unsigned System Integrity Policy</Option>
    </Rule>
    <Rule>
      <Option>Enabled:Advanced Boot Options Menu</Option>
    </Rule>
    <Rule>
      <Option>Required:Enforce Store Applications</Option>
    </Rule>
    <Rule>
      <Option>Enabled:UMCI</Option>
    </Rule>
  </Rules>
  <!--EKUS-->
  <EKUs />
  <!--File Rules-->
  <FileRules />
  <!--Signers-->
  <Signers>
    <Signer ID="ID_SIGNER_S_3" Name="DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1">
      <CertRoot Type="TBS" Value="65B1D4076A89AE273F57E6EEEDECB3EAE129B4168F76FA7671914CDF461D542255C59D9B85B916AE0CA6FC0FCF7A8E64" />
      <CertPublisher Value="Flexera Software LLC" />
    </Signer>
    <Signer ID="ID_SIGNER_S_6" Name="DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1">
      <CertRoot Type="TBS" Value="65B1D4076A89AE273F57E6EEEDECB3EAE129B4168F76FA7671914CDF461D542255C59D9B85B916AE0CA6FC0FCF7A8E64" />
      <CertPublisher Value="Finansiell ID-Teknik BID AB" />
    </Signer>
  </Signers>
  <!--Driver Signing Scenarios-->
  <SigningScenarios>
    <SigningScenario Value="131" ID="ID_SIGNINGSCENARIO_DRIVERS_1" FriendlyName="Auto generated policy on 10-23-2025">
      <ProductSigners />
    </SigningScenario>
    <SigningScenario Value="12" ID="ID_SIGNINGSCENARIO_WINDOWS" FriendlyName="Auto generated policy on 10-23-2025">
      <ProductSigners>
        <AllowedSigners>
          <AllowedSigner SignerId="ID_SIGNER_S_3" />
          <AllowedSigner SignerId="ID_SIGNER_S_6" />
        </AllowedSigners>
      </ProductSigners>
    </SigningScenario>
  </SigningScenarios>
  <UpdatePolicySigners />
  <CiSigners>
    <CiSigner SignerId="ID_SIGNER_S_3" />
    <CiSigner SignerId="ID_SIGNER_S_6" />
  </CiSigners>
  <HvciOptions>0</HvciOptions>
  <Settings>
    <Setting Provider="PolicyInfo" Key="Information" ValueName="Name">
      <Value>
        <String>Supplemental BankID</String>
      </Value>
    </Setting>
  </Settings>
  <BasePolicyID>{E0ABDA1F-CCF0-468E-8855-3E0F08B02D6A}</BasePolicyID>
  <PolicyID>{CC2544E3-C0A7-4187-91B0-2DBE7E36E893}</PolicyID>
</SiPolicy>
"@
