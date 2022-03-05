async function getZkSyncProvider(zksync, networkName) {
    let getZkSyncProvider
    try {
        zkSyncProvider = await zksync.getDefaultProvider(networkName)
    } catch (error) {
        console.log('Unable to connect to zkSync.')
        console.log(error)
    }
} //end function getZkSyncProvider()
return zkSyncProvider