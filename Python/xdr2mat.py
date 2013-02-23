#!/usr/bin/env python
"""Utility class for converting IDL xdr data to Matlab mat files

This script converts all the XDR files in a given path to MAT files.

TODO: add the logic for fname_suffix, if needed


Author: Jens Raaby
Date: 13/02/13
"""
from scipy import io
from scipy import misc
import os
import sys
from optparse import OptionParser


# Configuration - use CLI args if supplied
parser = OptionParser()
parser.add_option("-s","--src", dest="src_path",
                  help="read files from PATH", metavar="PATH", default='.')
parser.add_option("-d","--dst", dest="dst_path",
                  help="write files to PATH",metavar="PATH",default='./mat')
# parser.add_option("-f","--fsuff", dest="fname_suffix",
#                   help="destination files have suffix SUFFIX",metavar="SUFFIX",default='')

def listDirectoryXDRs(directory):
    "gets a list of all the xdr files in the supplied directory"
    print directory
    allFiles = [os.path.normcase(f) for f in os.listdir(directory)]
    allFiles = [os.path.join(directory,f) 
        for f in allFiles
         if os.path.splitext(f)[1] == '.xdr']
    return allFiles

def getXDRdict(filepath):
    "get the dict object for an xdr file"
    return io.readsav(filepath)

def convert(xdrFilePath,options):
    "Given the path to an xdr file, saves it's dictionary in a mat file"
    fname = os.path.splitext(xdrFilePath)[0]
    fname = os.path.split(fname)[1]
    fname = os.path.join(options.dst_path,fname)
    # now the important part...
    mdict = getXDRdict(xdrFilePath)
    io.savemat(fname,mdict,True)
  
def convertAll(xdrPaths,options):
    "Creates the destination folder if it does not exist, then converts all the xdr files."
    if os.path.isdir(options.dst_path) != True:
        os.mkdir(options.dst_path)
        
    for xdr in xdrPaths:
        print 'Converting ',xdr
        convert(xdr,options)

if __name__ == "__main__":
    (options,args) = parser.parse_args()
    xdrs = listDirectoryXDRs(options.src_path)
    convertAll(xdrs,options)
    
    
