module.exports =  (filePath,successCallBack,failureCallBack) => {
        cordova.exec(()=>{
                console.log("downloaded successfully");
            },
            ()=>{
                console.log("download failed in ios");
            },
             "FileDownload",
             "downloadFile",
        [filePath]);

}