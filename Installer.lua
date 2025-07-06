local gitInstallerHttp = "";
local request = http.get(gitInstallerHttp);
local fileData = request.readAll();
request.close();

local localFile = file.create("GitInstaller","w");
localFile.write(fileData);
localfile.close();

