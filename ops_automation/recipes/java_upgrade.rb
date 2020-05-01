java_version = "1.8.0"

#taking backup of /opt/vmware-jre
execute "/opt/vmware-jre" do
  not_if "/opt/vmware-jre/bin/java -version 2>&1 | egrep #{java_version}"
  command " cd /opt/vmware-jre/; tar zcf /backup/vmware-jre.tar *; rm -rf /opt/vmware-jre/* "
  action :run
end

#downloading java new version
execute "/opt/vmware-jre" do
  not_if "/opt/vmware-jre/bin/java -version 2>&1 | egrep #{java_version}"
  command "cd /opt/vmware-jre; wget artifactoryURL/Linux.tar.gz | tar zxf -"
  action :run
end
