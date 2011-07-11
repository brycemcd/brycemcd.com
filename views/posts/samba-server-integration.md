## Samba Server Integration

I recently returned from a trip to Beirut, Lebanon where I had been doing some humanitarian and mission work. One of my responsibilities was to create a file sharing server for a humanitarian organization.

Given the budget of next to nothing and the relatively small size of the office, I decided it was best to proceed with a Linux based Samba server. Although their office is 100% Microsoft (a mix of XP and Vista machines), Linux would be a great light weight solution. The added benefit was we re-purposed an ancient workstation (circa 1996) to run the Samba server so no new hardware was purchased and we prevented another machine from polluting a land fill.


We created three shared drives for the business.

  1. A share everyone in the office could access
  2. A share only the executive could access
  3. A share for the exclusive purpose of backing up everyone’s workstation
  4. I simply installed Centos 5.2 distribution on the old workstation, created three distinct user accounts and group permissions, enabled the samba service, and locked down access through iptables firewall.

Creating a secure, readable, smb.conf file was really important to me. Not only for readability but also because I won’t be supporting this server after installation. Any other administrator should be able to walk into the office and quickly & clearly see how to make edits for upgrades or changes.

The smb.conf file:
<script src="https://gist.github.com/1063891.js?file=smb.conf"></script>
<noscript>
#smb.conf

[global]
#set up what the end user would see on their desktop
workgroup = H4LSharedFiles
server string = common files for H4L

#general user perms
security = user
passdb backend = tdbsam

#printing support
load printers = no
printing = bsd
printcap name = /dev/null
show add printer wizard = no
disable spools = yes

[AllSharedFiles]
comment = Files for everyone to share
path = /sambashares/allAccess
writeable = yes
browseable = yes
guest ok = yes
write list = +allemployees

[Backup]
comment = Files to back up everyone's computer
path = /sambashares/backups
writeable = yes
browseable = yes
guest ok = yes
write list = +allemployees

[AdminOnly]
comment = Access for sensitive files
path = /sambashares/admins
writeable = yes
browseable = yes
guest ok = no
write list = +administrators
</noscript>
