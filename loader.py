class StepsLoader(object):
    @staticmethod
    def dependencies(params=None):
        deps = {}

        # Fedora/EPEL8 is python3-docker
        # CentOS 7 / EPEL7 is python36-docker or python-docker-py
        deps['python-docker'] = {
            'library': 'docker',
            'package': 'python3-docker',
            'centos7': {
                'package': 'python36-docker',
            }
        }

        # Fedora - python3-behave
        # EPEL 7 / EPEL 8 : MISSING
        deps['behave'] = {
            'library': 'behave',
            'package': 'python3-behave',
        }

        # Fedora / EPEL 8 : python3-requests
        # EPEL 7 : python36-requests
        deps['requests'] = {
            'library': 'requests',
            'package': 'python3-requests',
            'centos7': {
                'package': 'python36-requests',
            }
        }

        # Fedora / EPEL 8 : python3-lxml
        # EPEL 7 : python36-lxml
        deps['lxml'] = {
            'library': 'lxml',
            'package': 'python2-lxml',
            'centos7': {
                'package': 'python36-lxml',
            }
        }

        deps['s2i'] = {
            'executable': 's2i',
            'package': 'https://github.com/openshift/source-to-image'
        }

        return deps
