import ast
import os
import sys
from glob import glob

__all__ = ["read_filenames"]


def read_filenames(dir, filter, main_sensor_name, aux_sensor_name, filetype='png'):
    """
    Reads filenames for any arbitrary sensor combinations specified in the function call.
    Additionally the filetype can be specified. The image pair require to have the same name.
    :param dir:
    :return:
    """
    if sys.version_info[0] >= 3.6:
        num = lambda x: int("".join(filter(str.isdigit, os.path.basename(x))))
    else:
        num = lambda x: int("".join(filter(str.isdigit, ast.literal_eval(os.path.basename(x)))))
    if os.path.exists(dir):
        main_sensor_images = [file for path_tuple in os.walk(dir) for file in
                              glob(os.path.join(path_tuple[0], '*.' + filetype)) if
                              main_sensor_name in file and all([s in file for s in filter])]
        aux_sensor_images = [file for path_tuple in os.walk(dir) for file in
                             glob(os.path.join(path_tuple[0], '*.' + filetype)) if
                             aux_sensor_name in file and all([s in file for s in filter])]
        main_sensor_images.sort()
        aux_sensor_images.sort()

        # Sanity checks to make sure they have been read out with the same order
        assert len(aux_sensor_images) == len(main_sensor_images)
        cond = [num(aux_sensor_images[i]) == num(main_sensor_images[i]) for i in
                range(len(main_sensor_images))]
        assert all(cond)
        return list(zip(main_sensor_images, aux_sensor_images))
    else:
        raise IOError("\tThe requested directory does not exists")
