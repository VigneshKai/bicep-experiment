// replace vm-name and vm_name with the Virtual machine name 
// replace rg-name and rg_name with resource group name
param virtualMachines_vm_name string = 'vm-name'
param disks_vm_name_os_externalid string = '/subscriptions/6889ae45-3001-465d-9916-c2ef30f8ef51/resourceGroups/rg-name/providers/Microsoft.Compute/disks/vm-name-os'
param networkInterfaces_vm_name_externalid string = '/subscriptions/6889ae45-3001-465d-9916-c2ef30f8ef51/resourceGroups/rg-name/providers/Microsoft.Network/networkInterfaces/vm-name-ser477'

resource virtualMachines_vm_name_resource 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: virtualMachines_vm_name
  location: 'australiasoutheast'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    storageProfile: {
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_name}-os'
        createOption: 'Attach'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_vm_name_os_externalid
        }
        deleteOption: 'Detach'
        diskSizeGB: 32
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_name_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
