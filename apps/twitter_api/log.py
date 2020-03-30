import logging
import sys
from pythonjsonlogger import jsonlogger

class StackdriverJsonFormatter(jsonlogger.JsonFormatter, object):
    """Be very careful changing this formatter class.
    A lot of projects use it, and stackdriver requires a very specific
    format.
    """

    def __init__(self, fmt="%(levelname) %(message) %(filename)s %(lineno)d",
                 style='%', *args, **kwargs):
        jsonlogger.JsonFormatter.__init__(self, fmt=fmt, *args, **kwargs)

    def process_log_record(self, log_record):
        log_record['severity'] = log_record['levelname']
        del log_record['levelname']
        return super(StackdriverJsonFormatter, self).process_log_record(
            log_record)

    def add_fields(self, log_record, record, message_dict):
        super(StackdriverJsonFormatter, self).add_fields(log_record,
                                                         record, message_dict)
        # tz = pytz.timezone('America/Sao_Paulo')
        # dtime = datetime.now(tz)
        # dtime.isoformat()
        # log_record['timestamp'] = dtime
        file_formated = "{}:{}".format(log_record['filename'],
                                       log_record['lineno'])
        log_record['module'] = file_formated
        del log_record['filename']
        del log_record['lineno']



