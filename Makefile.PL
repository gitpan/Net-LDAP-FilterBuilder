use inc::Module::Install 0.67;
perl_version '5.008001';
  
name           'Net-LDAP-FilterBuilder';
all_from       'lib/Net/LDAP/FilterBuilder.pm';

test_requires  'Test::More' => 0;
test_requires  'Test::Pod' => 0;
test_requires  'Test::Pod::Coverage' => 0;

WriteAll;

