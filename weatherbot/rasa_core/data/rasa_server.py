import logging
import os
from rasa_core.interpreter import RasaNLUHttpInterpreter
from rasa_core.server import RasaCoreServer
from rasa_core.server import create_argument_parser

logger = logging.getLogger(__name__)

if __name__ == '__main__':
    # Script to run Rasa NLU HTTP Interpreter
    arg_parser = create_argument_parser()
    cmdline_args = arg_parser.parse_args()

    logging.basicConfig(level=cmdline_args.loglevel)
    if cmdline_args.nlu == 'RasaNLUHttpInterpreter':
        logger.info("Creating RasaNLU HTTP Interpreter")
        #Fill in the modelname and server details.
        cmdline_args.nlu = RasaNLUHttpInterpreter(model_name=os.environ.get("rasa_nlu_model_name"),
                                                token="",
                                                server=os.environ.get("rasa_nlu_http_server"),
                                                project_name=os.environ.get("rasa_nlu_project_name"))

    rasa = RasaCoreServer(cmdline_args.core,
                          cmdline_args.nlu,
                          cmdline_args.loglevel,
                          cmdline_args.log_file,
                          cmdline_args.cors,
                          auth_token=cmdline_args.auth_token)

    logger.info("Starting Rasa Core http server on port %s" % cmdline_args.port)
    rasa.app.run("0.0.0.0", cmdline_args.port)
