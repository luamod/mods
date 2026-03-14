--[[
  Most test cases were ported from CPython's posixpath tests.
  Adapted and ported to Lua/Busted for this project's API and conventions.
  Source: https://github.com/python/cpython/blob/main/Lib/test/test_posixpath.py
  License: Python Software Foundation License Version 2 (PSF-2.0).
  Copyright (c) 2001 Python Software Foundation; All Rights Reserved.
]]

local runtime = require "mods.runtime"
runtime.is_windows = false -- Make mods.path use mods.posixpath.

local lfs = require "lfs"
local path = require "mods.path"
local posixpath = require "mods.posixpath"
local tbl = require "mods.tbl"

local tbl_keys = tbl.keys
local fmt = string.format

describe("mods.posixpath", function()
  local cwd = lfs.currentdir()

  for _, fname in ipairs(tbl_keys(path)) do
    it(fmt("posixpath.%s is a function and equals path.%s", fname, fname), function()
      assert.is_function(posixpath[fname])
      assert.are_equal(posixpath[fname], path[fname])
    end)
  end

  -- stylua: ignore
  local tests = {
    abspath = {
      {{ "a"                 }, { posixpath.normpath(cwd .. "/a")      }},
      {{ "."                 }, { posixpath.normpath(cwd)              }},
      {{ ".."                }, { posixpath.normpath(cwd .. "/..")     }},
      {{ "a/./b"             }, { posixpath.normpath(cwd .. "/a/./b")  }},
      {{ "a/../b"            }, { posixpath.normpath(cwd .. "/a/../b") }},
      {{ "/a"                }, { "/a"                                 }},
      {{ "/a/./b"            }, { "/a/b"                               }},
      {{ "/a/../b"           }, { "/b"                                 }},
      {{ "//foo//bar/../baz" }, { "//foo/baz"                          }},
    },
    basename = {
      {{ "/foo/bar"   }, { "bar" }},
      {{ "/"          }, { ""    }},
      {{ "foo"        }, { "foo" }},
      {{ "////foo"    }, { "foo" }},
      {{ "//foo//bar" }, { "bar" }},
      {{ "/foo"       }, { "foo" }},
      {{ "foo/"       }, { ""    }},
    },
    commonpath = {
      {{{ "/a/b/c"    , "/a/b/d"         }}, { "/a/b"                     }},
      {{{ "a/b"       , "a/c"            }}, { "a"                        }},
      {{{ "//a/x"     , "/a/y"           }}, { "/a"                       }},
      {{{ "/foo/bar"                     }}, { "/foo/bar"                 }},
      {{{ "/foo/bar/" , "/foo/bar"       }}, { "/foo/bar"                 }},
      {{{ "/foo/bar/" , "/foo/bar/"      }}, { "/foo/bar"                 }},
      {{{ "/foo/./bar", "/./foo/bar"     }}, { "/foo/bar"                 }},
      {{{ "/"         , "/foo"           }}, { "/"                        }},
      {{{ "/foo"      , "/bar"           }}, { "/"                        }},
      {{{ "/foo/bar/" , "/foo/bar/baz"   }}, { "/foo/bar"                 }},
      {{{ "/foo/bar/" , "/foo/baz/"      }}, { "/foo"                     }},
      {{{ "/foo/bar"  , "/foo/baz"       }}, { "/foo"                     }},
      {{{ "/foo/bar/" , "/foo/baz"       }}, { "/foo"                     }},
      {{{ "foo"                          }}, { "foo"                      }},
      {{{ "foo"       , "foo"            }}, { "foo"                      }},
      {{{ "foo/bar"   , "foo/baz"        }}, { "foo"                      }},
      {{{ "foo//bar"  , "foo/baz//"      }}, { "foo"                      }},
      {{{ "foo/./bar" , "./foo/baz"      }}, { "foo"                      }},
      {{{ "foo/bar"   , "foo/baz", "foo" }}, { "foo"                      }},
      {{{ ""                             }}, { ""                         }},
      {{{ ""          , "foo/bar"        }}, { ""                         }},
      {{{                                }}, { nil, "paths list is empty" }},
    },
    dirname = {
      {{ "/"          }, { "/"     }},
      {{ "a"          }, { ""      }},
      {{ "/foo/bar"   }, { "/foo"  }},
      {{ "////foo"    }, { "////"  }},
      {{ "//foo//bar" }, { "//foo" }},
    },
    isabs = {
      {{ ""         }, { false }},
      {{ "/"        }, { true  }},
      {{ "/a"       }, { true  }},
      {{ "/foo/bar" }, { true  }},
      {{ "a/b"      }, { false }},
    },
    join = {
      {{ "/foo" , "bar" , "/bar", "baz" }, { "/bar/baz"      }},
      {{ "/foo" , "bar" , "baz"         }, { "/foo/bar/baz"  }},
      {{ "/foo/", "bar/", "baz/"        }, { "/foo/bar/baz/" }},
      {{ "a"    , ""                    }, { "a/"            }},
      {{ "a"    , ""    , ""            }, { "a/"            }},
      {{ "a"    , "b"                   }, { "a/b"           }},
      {{ "a"    , "b/"                  }, { "a/b/"          }},
      {{ "a/"   , "b"                   }, { "a/b"           }},
      {{ "a/"   , "b/"                  }, { "a/b/"          }},
      {{ "a"    , "b/c" , "d"           }, { "a/b/c/d"       }},
      {{ "a"    , "b//c", "d"           }, { "a/b//c/d"      }},
      {{ "a"    , "b/c/", "d"           }, { "a/b/c/d"       }},
      {{ "/a"   , "b"                   }, { "/a/b"          }},
      {{ "/a/"  , "b"                   }, { "/a/b"          }},
      {{ "a"    , "/b"  , "c"           }, { "/b/c"          }},
      {{ "a"    , "/b"  , "/c"          }, { "/c"            }},
      {{ ""     , "a"                   }, { "a"             }},
      {{ "a/"   , "b/"  , "c"           }, { "a/b/c"         }},
      {{ "/a"   , "b"   , "c"           }, { "/a/b/c"        }},
    },
    normcase = {
      {{ "A/B" }, { "A/B" }},
    },
    normpath = {
      {{ ""                                }, { "."              }},
      {{ "/"                               }, { "/"              }},
      {{ "/."                              }, { "/"              }},
      {{ "/./"                             }, { "/"              }},
      {{ "/.//."                           }, { "/"              }},
      {{ "/./foo/bar"                      }, { "/foo/bar"       }},
      {{ "/foo"                            }, { "/foo"           }},
      {{ "/foo/bar"                        }, { "/foo/bar"       }},
      {{ "//"                              }, { "//"             }},
      {{ "///"                             }, { "/"              }},
      {{ "///foo/.//bar//"                 }, { "/foo/bar"       }},
      {{ "///foo/.//bar//.//..//.//baz///" }, { "/foo/baz"       }},
      {{ "///..//./foo/.//bar"             }, { "/foo/bar"       }},
      {{ "."                               }, { "."              }},
      {{ ".//."                            }, { "."              }},
      {{ "./foo/bar"                       }, { "foo/bar"        }},
      {{ ".."                              }, { ".."             }},
      {{ "../"                             }, { ".."             }},
      {{ "../foo"                          }, { "../foo"         }},
      {{ "../../foo"                       }, { "../../foo"      }},
      {{ "../foo/../bar"                   }, { "../bar"         }},
      {{ "../../foo/../bar/./baz/boom/.."  }, { "../../bar/baz"  }},
      {{ "/.."                             }, { "/"              }},
      {{ "/.."                             }, { "/"              }},
      {{ "/../"                            }, { "/"              }},
      {{ "/..//"                           }, { "/"              }},
      {{ "//."                             }, { "//"             }},
      {{ "//.."                            }, { "//"             }},
      {{ "//..."                           }, { "//..."          }},
      {{ "//../foo"                        }, { "//foo"          }},
      {{ "//../../foo"                     }, { "//foo"          }},
      {{ "/../foo"                         }, { "/foo"           }},
      {{ "/../../foo"                      }, { "/foo"           }},
      {{ "/../foo/../"                     }, { "/"              }},
      {{ "/../foo/../bar"                  }, { "/bar"           }},
      {{ "/../../foo/../bar/./baz/boom/.." }, { "/bar/baz"       }},
      {{ "/../../foo/../bar/./baz/boom/."  }, { "/bar/baz/boom"  }},
      {{ "foo/../bar/baz"                  }, { "bar/baz"        }},
      {{ "foo/../../bar/baz"               }, { "../bar/baz"     }},
      {{ "foo/../../../bar/baz"            }, { "../../bar/baz"  }},
      {{ "foo///../bar/.././../baz/boom"   }, { "../baz/boom"    }},
      {{ "foo/bar/../..///../../baz/boom"  }, { "../../baz/boom" }},
      {{ "/foo/.."                         }, { "/"              }},
      {{ "/foo/../.."                      }, { "/"              }},
      {{ "//foo/.."                        }, { "//"             }},
      {{ "//foo/../.."                     }, { "//"             }},
      {{ "///foo/.."                       }, { "/"              }},
      {{ "///foo/../.."                    }, { "/"              }},
      {{ "////foo/.."                      }, { "/"              }},
      {{ "/////foo/.."                     }, { "/"              }},
    },
    relpath = {
      {{ "/a/b/c"      , "/a"       }, { "b/c"                  }},
      {{ "/a"          , "/a"       }, { "."                    }},
      {{ "/a/b"        , "/a/b/c"   }, { ".."                   }},
      {{ "/foo/bar/baz", "/foo/bar" }, { "baz"                  }},
      {{ "/foo/bar/baz", "/"        }, { "foo/bar/baz"          }},
      {{ "/"           , "/foo/bar" }, { "../.."                }},
      {{ "/foo/bar/baz", "/x/y/z"   }, { "../../../foo/bar/baz" }},
      {{ "a/b"         , "a"        }, { "b"                    }},
      {{ "a"           , "a/b"      }, { ".."                   }},
      {{ "a"           , "a"        }, { "."                    }},
      {{ "foo/bar"     , "foo/baz"  }, { "../bar"               }},
      {{ "foo"         , "."        }, { "foo"                  }},
      {{ "."           , "foo/bar"  }, { "../.."                }},
    },
    split = {
      {{ "/a/b/c.txt" }, { "/a/b" , "c.txt" }},
      {{ "/"          }, { "/"    , ""      }},
      {{ "a"          }, { ""     , "a"     }},
      {{ "a/"         }, { "a"    , ""      }},
      {{ "////foo"    }, { "////" , "foo"   }},
      {{ "//foo//bar" }, { "//foo", "bar"   }},
    },
    splitdrive = {
      {{"/a/b"}, {"", "/a/b"}},
    },
    splitext = {
      {{ "foo.bar"          }, { "foo"              , ".bar" }},
      {{ "foo.boo.bar"      }, { "foo.boo"          , ".bar" }},
      {{ "foo.boo.biff.bar" }, { "foo.boo.biff"     , ".bar" }},
      {{ ".csh.rc"          }, { ".csh"             , ".rc"  }},
      {{ "nodots"           }, { "nodots"           , ""     }},
      {{ ".cshrc"           }, { ".cshrc"           , ""     }},
      {{ "...manydots.ext"  }, { "...manydots"      , ".ext" }},
      {{ "."                }, { "."                , ""     }},
      {{ ".."               }, { ".."               , ""     }},
      {{ "..."              }, { "..."              , ""     }},
      {{ "...."             }, { "...."             , ""     }},
      {{ ""                 }, { ""                 , ""     }},
      {{ "archive.tar.gz"   }, { "archive.tar"      , ".gz"  }},
      {{ ".bashrc"          }, { ".bashrc"          , ""     }},
      {{ "a/b/c.txt"        }, { "a/b/c"            , ".txt" }},
      {{ "noext"            }, { "noext"            , ""     }},
      {{ "abc.def/path.txt/"}, { "abc.def/path.txt/", ""     }},
    },
    splitroot = {
      {{ ""        }, { "", ""  , ""       }},
      {{ "a"       }, { "", ""  , "a"      }},
      {{ "a/b"     }, { "", ""  , "a/b"    }},
      {{ "a/b/"    }, { "", ""  , "a/b/"   }},
      {{ "/a"      }, { "", "/" , "a"      }},
      {{ "/a/b"    }, { "", "/" , "a/b"    }},
      {{ "/a/b/"   }, { "", "/" , "a/b/"   }},
      {{ "//a"     }, { "", "//", "a"      }},
      {{ "///a"    }, { "", "/" , "//a"    }},
      {{ "///a/b"  }, { "", "/" , "//a/b"  }},
      {{ "c:/a/b"  }, { "", ""  , "c:/a/b" }},
      {{ "\\/a/b"  }, { "", ""  , "\\/a/b" }},
      {{ "\\a\\b"  }, { "", ""  , "\\a\\b" }},
    },
  }

  for _, fname in ipairs(tbl_keys(tests)) do
    local cases = tests[fname]
    for i = 1, #cases do
      local params, expected = unpack(cases[i], 1, 3)

      it(fmt("%s(%s)", fname, args_repr(params)), function()
        assert.are_same(expected, { posixpath[fname](unpack(params)) })
      end)
    end
  end

  it("expanduser()", function()
    assert.are_equal("foo", posixpath.expanduser("foo"))
    local home = os.getenv("HOME")
    if home and home ~= "" then
      assert.are_equal(home, posixpath.expanduser("~"))
      assert.are_equal(home .. "/tmp", posixpath.expanduser("~/tmp"))
    else
      local value, err = posixpath.expanduser("~")
      assert.is_nil(value)
      assert.is_string(err)
    end
  end)

  it("home()", function()
    local home = os.getenv("HOME")
    local value, err = posixpath.home()

    if home and home ~= "" then
      assert.are_equal(home, value)
      assert.is_nil(err)
    else
      assert.is_nil(value)
      assert.is_string(err)
    end
  end)

  it("relpath()", function()
    local value, err = posixpath.relpath("")
    assert.is_nil(value)
    assert.are_equal("no path specified", err)
  end)

  it("commonpath()", function()
    assert.has_error(posixpath.commonpath, "bad argument #1 (expected table, got no value)")
    local value, err = posixpath.commonpath({})
    assert.is_nil(value)
    assert.are_equal("paths list is empty", err)
    local value, err = posixpath.commonpath({ "/a", "b" })
    assert.is_nil(value)
    assert.are_equal("can't mix absolute and relative paths", err)
  end)
end)
