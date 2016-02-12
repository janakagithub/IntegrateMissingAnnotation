use integrate_probable_annotation::integrate_probable_annotationImpl;

use integrate_probable_annotation::integrate_probable_annotationServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = integrate_probable_annotation::integrate_probable_annotationImpl->new;
    push(@dispatch, 'integrate_probable_annotation' => $obj);
}


my $server = integrate_probable_annotation::integrate_probable_annotationServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
