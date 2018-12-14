#%PAM-1.0
auth sufficient /lib64/security/pam_radius_auth.so
auth include	password-auth
account required	pam_nologin.so
account include	password-auth
session include	password-auth
