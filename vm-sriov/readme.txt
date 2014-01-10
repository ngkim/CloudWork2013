* Guide for starting a VM with a SR-IOV VF

1. Download and install ixgbe driver
   - Download latest ixgbe driver from 
     https://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=14687 
   - Install ixgbe driver
   # cd ixgbe/ixgbe-3.15.1/src
   # make install

2. Create VFs
   # ./init_ixgbe_vf.sh

3. Choose a VF and unbind it
   - Choose a VF from PCI device list (e.g., 04:10.0)
   # lspci | grep 82599
   # ./unbind_ixgbe.sh 04:10.0

4. Start VM with the VF ID
   # ./start_vm.sh 04:10.0 2
   
