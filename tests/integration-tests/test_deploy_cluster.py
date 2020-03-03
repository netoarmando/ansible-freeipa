

class TestDeployCluster:
    def test_server_replica_client_install(self, multihost):
        print(dir(multihost.config))
        print(multihost.config.domains)
        assert False
