package integrate_probable_annotation::integrate_probable_annotationImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

integrate_probable_annotation

=head1 DESCRIPTION

A KBase module: integrate_probable_annotation
This module intergrate probable annoation into a genome object.

=cut

#BEGIN_HEADER
use Bio::KBase::AuthToken;
use Bio::KBase::workspace::Client;
use Config::IniFiles;
use Data::Dumper;
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR

    my $config_file = $ENV{ KB_DEPLOYMENT_CONFIG };
    my $cfg = Config::IniFiles->new(-file=>$config_file);
    my $wsInstance = $cfg->val('integrate_probable_annotation','workspace-url');
    die "no workspace-url defined" unless $wsInstance;

    $self->{'workspace-url'} = $wsInstance;

    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 integrate_annotation

  $return = $obj->integrate_annotation($workspace_name, $genome_id, $missing_role_data, $outputGenome)

=over 4

=item Parameter and return types

=begin html

<pre>
$workspace_name is an integrate_probable_annotation.workspace_name
$genome_id is an integrate_probable_annotation.genome_id
$missing_role_data is an integrate_probable_annotation.missing_role_data
$outputGenome is an integrate_probable_annotation.outputGenome
$return is an integrate_probable_annotation.missingRoleHits
workspace_name is a string
genome_id is a string
missing_role_data is a string
outputGenome is a string
missingRoleHits is a reference to a hash where the following keys are defined:
	missingRoles has a value which is a reference to a list where each element is an integrate_probable_annotation.MissingRolesData
MissingRolesData is a reference to a hash where the following keys are defined:
	role_description has a value which is a string
	perc_identity has a value which is a float
	genome_hits has a value which is an int
	hit_location has a value which is a string
	blast_score has a value which is a string
	protein_sequence has a value which is a string

</pre>

=end html

=begin text

$workspace_name is an integrate_probable_annotation.workspace_name
$genome_id is an integrate_probable_annotation.genome_id
$missing_role_data is an integrate_probable_annotation.missing_role_data
$outputGenome is an integrate_probable_annotation.outputGenome
$return is an integrate_probable_annotation.missingRoleHits
workspace_name is a string
genome_id is a string
missing_role_data is a string
outputGenome is a string
missingRoleHits is a reference to a hash where the following keys are defined:
	missingRoles has a value which is a reference to a list where each element is an integrate_probable_annotation.MissingRolesData
MissingRolesData is a reference to a hash where the following keys are defined:
	role_description has a value which is a string
	perc_identity has a value which is a float
	genome_hits has a value which is an int
	hit_location has a value which is a string
	blast_score has a value which is a string
	protein_sequence has a value which is a string


=end text



=item Description



=back

=cut

sub integrate_annotation
{
    my $self = shift;
    my($workspace_name, $genome_id, $missing_role_data, $outputGenome) = @_;

    my @_bad_arguments;
    (!ref($workspace_name)) or push(@_bad_arguments, "Invalid type for argument \"workspace_name\" (value was \"$workspace_name\")");
    (!ref($genome_id)) or push(@_bad_arguments, "Invalid type for argument \"genome_id\" (value was \"$genome_id\")");
    (!ref($missing_role_data)) or push(@_bad_arguments, "Invalid type for argument \"missing_role_data\" (value was \"$missing_role_data\")");
    (!ref($outputGenome)) or push(@_bad_arguments, "Invalid type for argument \"outputGenome\" (value was \"$outputGenome\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to integrate_annotation:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'integrate_annotation');
    }

    my $ctx = $integrate_probable_annotation::integrate_probable_annotationServer::CallContext;
    my($return);
    #BEGIN integrate_annotation
    my $missingRoleOut = {
        missingRoles => []
    };

    my $token=$ctx->token;
    my $wshandle=Bio::KBase::workspace::Client->new($self->{'workspace-url'},token=>$token);
    my $g_id=$wshandle->get_objects([{workspace=>$workspace_name,name=>$genome_id}]);
    my $m_role=$wshandle->get_objects([{workspace=>$workspace_name,name=>$missing_role_data}]);

    my $roleData = $m_role->[0]->{data}->{missing_roles};
    my $gn = $g_id->[0]->{data};
    my $feat = $gn->{features};

    for(my $i=0; $i< @{$roleData}; $i++){
        my $roleOut;
        my $gen;
        $gen->{id} = "missingRole:$i";
        $gen->{type}= "probable_annotation";
        $gen->{function} = $roleData->[$i]->{role_description};
        $roleOut->{role_description}= $roleData->[$i]->{role_description};
        my $hit_location = $roleData->[$i]->{hit_location};
        my $loc_Arr;
        my @hl = split /:/, $hit_location;

        my @contig =split /_/, $hl[1];
        push (@{$loc_Arr}, $contig[0]);
        my @codM = split /-/, $contig[1];
        my @codP = split /\+/, $contig[1];
        $codM[0] = $codM[0]+0;
        $codM[1] = $codM[1]+0;
        $codP[0] = $codP[0]+0;
        $codP[1] = $codP[1]+0;

        if ($contig[1] =~ /\+/){
            push (@{$loc_Arr}, $codP[0]);
            push (@{$loc_Arr}, "+");
            push (@{$loc_Arr}, $codP[1]);
        }
         if ($contig[1] =~ /-/){
            push (@{$loc_Arr}, $codM[0]);
            push (@{$loc_Arr}, "+");
            push (@{$loc_Arr}, $codM[1]);
        }


        $gen->{location}->[0] = $loc_Arr;


        $roleOut->{hit_location} = $roleData->[$i]->{hit_location};
        my $genome_hits =$roleData->[$i]->{genome_hits};

        $roleOut->{genome_hits}= $roleData->[$i]->{genome_hits};
        my $blast_score = $roleData->[$i]->{blast_score};
        $roleOut->{blast_score}= $roleData->[$i]->{blast_score};
        my $perc_identity = $roleData->[$i]->{perc_identity};
        $roleOut->{perc_identity} =$roleData->[$i]->{perc_identity};
        my $protein_sequence = $roleData->[$i]->{protein_sequence};

        $roleOut->{protein_sequence} = $roleData->[$i]->{protein_sequence};
        $gen->{protein_translation} = $roleData->[$i]->{protein_sequence};
        push (@{$missingRoleOut->{missingRoles}},$roleOut);
        push (@{$feat}, $gen);
        #print &Dumper ($gen);

    }

    my $saveObjectParams;
    $saveObjectParams->{workspace}=$workspace_name;
    $saveObjectParams->{objects}->[0]->{type} = "KBaseGenomes.Genome";
    $saveObjectParams->{objects}->[0]->{data} = $gn;
    $saveObjectParams->{objects}->[0]->{name} = $outputGenome;


    my $meta = $wshandle->save_objects($saveObjectParams);
    print &Dumper ($gn);
    $return = { 'missingRoleOut' => $missingRoleOut};


    #END integrate_annotation
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to integrate_annotation:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'integrate_annotation');
    }
    return($return);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
}

=head1 TYPES



=head2 genome_id

=over 4



=item Description

A string representing a genome id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 outputGenome

=over 4



=item Description

A string representing a output genome id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 workspace_name

=over 4



=item Description

A string representing a workspace name.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 missing_role_data

=over 4



=item Description

A string representing a missing Role data.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 MissingRolesData

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
role_description has a value which is a string
perc_identity has a value which is a float
genome_hits has a value which is an int
hit_location has a value which is a string
blast_score has a value which is a string
protein_sequence has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
role_description has a value which is a string
perc_identity has a value which is a float
genome_hits has a value which is an int
hit_location has a value which is a string
blast_score has a value which is a string
protein_sequence has a value which is a string


=end text

=back



=head2 missingRoleHits

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
missingRoles has a value which is a reference to a list where each element is an integrate_probable_annotation.MissingRolesData

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
missingRoles has a value which is a reference to a list where each element is an integrate_probable_annotation.MissingRolesData


=end text

=back



=cut

1;
