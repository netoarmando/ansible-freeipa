import pytest
import pytest_multihost


class MultihostConfig(pytest_multihost.config.Config):
    def filter(self, descriptions):
        """
        Override default behavior to not filter hosts, so that it can work
        with dynamic topologies.
        """
        return


@pytest.fixture(scope="session", autouse=True)
def multihost(request):
    #
    mh = pytest_multihost.make_multihost_fixture(
        request,
        descriptions=[],
        config_class=MultihostConfig
    )

    return mh
