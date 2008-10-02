#!/usr/bin/perl

use Test::More 'no_plan';
BEGIN { use_ok('Net::LDAP::FilterBuilder') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is( Net::LDAP::FilterBuilder->new( sn => 'Gorwits' ),
    '(sn=Gorwits)'
 );

is( Net::LDAP::FilterBuilder->new( sn => [ 'Gorwits', 'Edwards', 'Morrell' ] ),
    '(|(sn=Gorwits)(sn=Edwards)(sn=Morrell))' );

is( Net::LDAP::FilterBuilder->new( sn => [ 'Gorwits', 'Edwards' ], givenName => 'Guy' ),
    '(&(|(sn=Gorwits)(sn=Edwards))(givenName=Guy))' );

is( Net::LDAP::FilterBuilder->new( sn => [ 'Gorwits', 'Edwards' ] )->and( givenName => 'Oliver' ),
    '(&(|(sn=Gorwits)(sn=Edwards))(givenName=Oliver))' );

is( Net::LDAP::FilterBuilder->new( sn => 'Gorwits' )->or( sn => 'Edwards' )->and( givenName => 'Oliver' ),
    '(&(|(sn=Gorwits)(sn=Edwards))(givenName=Oliver))' );

is( Net::LDAP::FilterBuilder->new( sn => 'Gorwits' )->or( Net::LDAP::FilterBuilder->new( sn => 'Edwards' )->and( givenName => 'Oliver' ) ),
    '(|(sn=Gorwits)(&(sn=Edwards)(givenName=Oliver)))' );

is( Net::LDAP::FilterBuilder->new( sn => 'Gorwits' )->or( sn => 'Edwards' )->and( givenName => 'Oliver' )->not,
    '(!(&(|(sn=Gorwits)(sn=Edwards))(givenName=Oliver)))' );

is( Net::LDAP::FilterBuilder->new( sn => ['Gorwits', 'Edwards'] )->and( Net::LDAP::FilterBuilder->new( givenName => 'Oliver' )->not ),
    '(&(|(sn=Gorwits)(sn=Edwards))(!(givenName=Oliver)))' );

is( Net::LDAP::FilterBuilder->new( sn => 'foo*bar' ),
    '(sn=foo\*bar)' );

is( Net::LDAP::FilterBuilder->new( sn => \'foo*bar' ),
    '(sn=foo*bar)' );

is( Net::LDAP::FilterBuilder->new( sn => \'*' ),
    '(sn=*)' );

is( Net::LDAP::FilterBuilder->new( '>=', dateOfBirth => '19700101000000Z' ),
    '(dateOfBirth>=19700101000000Z)' );
