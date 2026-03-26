import jenkins.security.s2m.AdminWhitelistRule;
import hudson.security.csrf.DefaultCrumbIssuer;
import hudson.util.PersistedList;
import jenkins.model.Jenkins;
import jenkins.model.*;
import jenkins.install.*;
import hudson.security.*;
import hudson.model.*;


// Set Hudson Security
def jenkins = Jenkins.getInstance()
def securityRealm = new HudsonPrivateSecurityRealm(false, false, null)
jenkins.setSecurityRealm(securityRealm)

def adminUsername = 'admin'
def adminPassword = 'admin'
securityRealm.createAccount(adminUsername, adminPassword)
println " [groovy-init-jenkins] Admin user created"
if (adminUsername != 'admin') {
    // Delete the existing by default admin account
    User u = User.get('admin')
    u.delete()
}

// Set Authorization strategy
println " [groovy-init-jenkins] Setting Authorization Strategy"
def authStrategy = new FullControlOnceLoggedInAuthorizationStrategy();
authStrategy.setAllowAnonymousRead(false);
jenkins.setAuthorizationStrategy(authStrategy);
println " [groovy-init-jenkins] Authorization Strategy set"

// require a crumb issuer
println " [groovy-init-jenkins] Enabling CSRF Protection"
jenkins.setCrumbIssuer(new DefaultCrumbIssuer(true));
println " [groovy-init-jenkins] CSRF Protection enabled"

// Set master-slave security
println " [groovy-init-jenkins] Setting master-slave security"
jenkins.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false);
println " [groovy-init-jenkins] master-slave security set"


// Setting email address
println " [groovy-init-jenkins] Configuring Jenkins adminstrator email address"
location = jenkins.model.JenkinsLocationConfiguration.get()
location.setAdminAddress("admin@example")
location.save()
println " [groovy-init-jenkins] Jenkins email is set to '{{JENKINS_EMAIL}}'"



def site = "https://cdn.jsdelivr.net/gh/lework/jenkins-update-center/updates/ustc/update-center.json";
PersistedList<UpdateSite> sites = jenkins.getUpdateCenter().getSites();
for (UpdateSite s: sites) {
  if (s.getId().equals(UpdateCenter.ID_DEFAULT))
    sites.remove(s);
}
sites.add(new UpdateSite(UpdateCenter.ID_DEFAULT, site));

Set<String> disabledAdministrativeMonitors = new HashSet<>();
disabledAdministrativeMonitors.add("hudson.model.UpdateCenter\$CoreUpdateMonitor");
disabledAdministrativeMonitors.add("hudson.diagnosis.TooManyJobsButNoView");
jenkins.setDisabledAdministrativeMonitors(disabledAdministrativeMonitors);






// println " [groovy-init-jenkins] setting Global properties (Environment variables)..."
// def globalNodeProperties = jenkins.getGlobalNodeProperties();
// def envVarsNodePropertyList = globalNodeProperties.getAll(hudson.slaves.EnvironmentVariablesNodeProperty.class)

// if ( envVarsNodePropertyList == null || envVarsNodePropertyList.size() == 0 ) {
//     newEnvVarsNodeProperty = new hudson.slaves.EnvironmentVariablesNodeProperty();
//     globalNodeProperties.add(newEnvVarsNodeProperty)
//     envVars = newEnvVarsNodeProperty.getEnvVars()
//   } else {
//     envVars = envVarsNodePropertyList.get(0).getEnvVars()
//   }
// envVars.put("PATH", "/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin")
// envVars.put("foo", "bar")
// println " [groovy-init-jenkins] setting Global properties (Environment variables)... done!"


jenkins.setNumExecutors(1);
jenkins.setNoUsageStatistics(true);

//System.setProperty('jenkins.model.Jenkins.slaveAgentPortEnforce', true);
//jenkins.setSlaveAgentPort(50001);

jenkins.save()

// Complete wizard
// println " [groovy-init-jenkins] Passing wizard"
// def wizard = new SetupWizard()
// wizard.init(true)
// wizard.completeSetup()
// println " [groovy-init-jenkins] Wizard passed"



// def command = "java -jar /usr/lib/jenkins-plugin-manager.jar --jenkins-update-center https://cdn.jsdelivr.net/gh/lework/jenkins-update-center/updates/tencent/update-center.json -f /var/jenkins_home/plugins.txt --verbose -d /var/jenkins_home/plugins"
// def command = "JENKINS_UC_DOWNLOAD=https://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/; java -jar /usr/lib/jenkins-plugin-manager.jar --jenkins-update-center https://cdn.jsdelivr.net/gh/lework/jenkins-update-center/updates/ustc/update-center.json --verbose -d /var/jenkins_home/plugins -p workflow-aggregator pipeline-utility-steps maven-plugin docker-workflow kubernetes configuration-as-code"
// def proc = command.execute()
// proc.waitFor()
// println "Process exit code: ${proc.exitValue()}"
// println "Std Err: ${proc.err.text}"
// println "Std Out: ${proc.in.text}"

//installPlugin("git")
//installPlugin("pipeline-utility-steps")

