// GENERATED from interpol_dental_code.xlsx — do not hand-edit
import '../models/code_node.dart';

List<String> availableCategories() => _tree.keys.toList(growable: false);

// listChildrenInTree(...) 전체를 이렇게 교체
List<CodeNode> listChildrenInTree(String category, List<String> prefix) {
  final root = _tree[category];
  if (root == null) return const <CodeNode>[];

  // 노드/자식 접근 시, Map<dynamic, dynamic> → Map<String, Object?> 로 안전 캐스팅
  Map<String, Object?> node = (root as Map).cast<String, Object?>();

  // prefix로 내려가기
  for (final step in prefix) {
    final kids = (node["_children"] as Map?)?.cast<String, Object?>() ?? const <String, Object?>{};
    final next = kids[step];
    if (next is Map) {
      node = next.cast<String, Object?>(); // 안전 캐스팅
    } else {
      return const <CodeNode>[];
    }
  }

  // 현재 레벨의 children 뽑기
  final kids = (node["_children"] as Map?)?.cast<String, Object?>() ?? const <String, Object?>{};
  final out = <CodeNode>[];
  kids.forEach((code, val) {
    String label = "";
    if (val is Map) {
      final m = val.cast<String, Object?>();
      final raw = m["_label"];
      if (raw is String) label = raw;
    }
    out.add(CodeNode(code, label));
  });
  out.sort((a, b) => a.code.compareTo(b.code));
  return out;
}

const Map<String, Map<String, Object>> _tree = {
  "Bite and occlusion": {
    "_label": "",
    "_children": {
      "cbt": {
        "_label": "cbt",
        "_children": {

        }
      },
      "dbt": {
        "_label": "dbt",
        "_children": {

        }
      },
      "dio": {
        "_label": "dio",
        "_children": {

        }
      },
      "ebt": {
        "_label": "ebt",
        "_children": {

        }
      },
      "hbt": {
        "_label": "hbt",
        "_children": {

        }
      },
      "meo": {
        "_label": "meo",
        "_children": {

        }
      },
      "noo": {
        "_label": "noo",
        "_children": {

        }
      },
      "obt": {
        "_label": "obt",
        "_children": {

        }
      },
      "rbt": {
        "_label": "rbt",
        "_children": {

        }
      },
      "sbt": {
        "_label": "sbt",
        "_children": {

        }
      }
    }
  },
  "Bridges": {
    "_label": "",
    "_children": {
      "abu": {
        "_label": "abu",
        "_children": {
          "uib": {
            "_label": "uib",
            "_children": {
              "extension bridge": {
                "_label": "",
                "_children": {

                }
              },
              "mtb": {
                "_label": "mtb",
                "_children": {
                  "gob": {
                    "_label": "gob",
                    "_children": {

                    }
                  },
                  "meb": {
                    "_label": "meb",
                    "_children": {

                    }
                  }
                }
              },
              "tcb": {
                "_label": "tcb",
                "_children": {
                  "acb": {
                    "_label": "acb",
                    "_children": {

                    }
                  },
                  "etb": {
                    "_label": "etb",
                    "_children": {

                    }
                  },
                  "mcb": {
                    "_label": "mcb",
                    "_children": {

                    }
                  },
                  "pob": {
                    "_label": "pob",
                    "_children": {

                    }
                  }
                }
              },
              "teb": {
                "_label": "teb",
                "_children": {

                }
              }
            }
          }
        }
      },
      "can": {
        "_label": "can",
        "_children": {

        }
      },
      "pon": {
        "_label": "pon",
        "_children": {
          "uip": {
            "_label": "uip",
            "_children": {
              "mtp": {
                "_label": "mtp",
                "_children": {
                  "gop": {
                    "_label": "gop",
                    "_children": {

                    }
                  },
                  "mep": {
                    "_label": "mep",
                    "_children": {

                    }
                  }
                }
              },
              "tcp": {
                "_label": "tcp",
                "_children": {
                  "acp": {
                    "_label": "acp",
                    "_children": {

                    }
                  },
                  "mcp": {
                    "_label": "mcp",
                    "_children": {

                    }
                  },
                  "pop": {
                    "_label": "pop",
                    "_children": {

                    }
                  },
                  "tep": {
                    "_label": "tep",
                    "_children": {

                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "Crown pathology": {
    "_label": "",
    "_children": {
      "abr": {
        "_label": "abr",
        "_children": {

        }
      },
      "att": {
        "_label": "att",
        "_children": {

        }
      },
      "ero": {
        "_label": "ero",
        "_children": {

        }
      },
      "flu": {
        "_label": "flu",
        "_children": {

        }
      }
    }
  },
  "Crowns": {
    "_label": "",
    "_children": {
      "uic": {
        "_label": "uic",
        "_children": {
          "mtc": {
            "_label": "mtc",
            "_children": {
              "amc": {
                "_label": "amc",
                "_children": {

                }
              },
              "goc": {
                "_label": "goc",
                "_children": {

                }
              },
              "mec": {
                "_label": "mec",
                "_children": {

                }
              },
              "shc": {
                "_label": "shc",
                "_children": {

                }
              },
              "stc": {
                "_label": "stc",
                "_children": {

                }
              }
            }
          },
          "tcc": {
            "_label": "tcc",
            "_children": {
              "acc": {
                "_label": "acc",
                "_children": {

                }
              },
              "mcc": {
                "_label": "mcc",
                "_children": {

                }
              },
              "poc": {
                "_label": "poc",
                "_children": {

                }
              },
              "vec": {
                "_label": "vec",
                "_children": {

                }
              }
            }
          },
          "tec": {
            "_label": "tec",
            "_children": {

            }
          }
        }
      }
    }
  },
  "Dentures and orthodontic appl.": {
    "_label": "",
    "_children": {
      "cla": {
        "_label": "cla",
        "_children": {

        }
      },
      "ede": {
        "_label": "ede",
        "_children": {

        }
      },
      "fld": {
        "_label": "fld",
        "_children": {

        }
      },
      "foa": {
        "_label": "foa",
        "_children": {

        }
      },
      "fud": {
        "_label": "fud",
        "_children": {

        }
      },
      "hld": {
        "_label": "hld",
        "_children": {

        }
      },
      "hud": {
        "_label": "hud",
        "_children": {

        }
      },
      "pld": {
        "_label": "pld",
        "_children": {

        }
      },
      "pud": {
        "_label": "pud",
        "_children": {

        }
      },
      "roa": {
        "_label": "roa",
        "_children": {

        }
      },
      "spl": {
        "_label": "spl",
        "_children": {

        }
      }
    }
  },
  "Fillings": {
    "_label": "",
    "_children": {
      "car": {
        "_label": "car",
        "_children": {
          "aca": {
            "_label": "aca",
            "_children": {

            }
          },
          "cca": {
            "_label": "cca",
            "_children": {

            }
          }
        }
      },
      "jew": {
        "_label": "jew",
        "_children": {

        }
      },
      "uif": {
        "_label": "uif",
        "_children": {
          "cav": {
            "_label": "cav",
            "_children": {

            }
          },
          "mcf": {
            "_label": "mcf",
            "_children": {
              "amf": {
                "_label": "amf",
                "_children": {

                }
              },
              "gof": {
                "_label": "gof",
                "_children": {

                }
              }
            }
          },
          "tcf": {
            "_label": "tcf",
            "_children": {
              "cef": {
                "_label": "cef",
                "_children": {

                }
              },
              "cof": {
                "_label": "cof",
                "_children": {

                }
              },
              "fis": {
                "_label": "fis",
                "_children": {

                }
              },
              "gif": {
                "_label": "gif",
                "_children": {

                }
              }
            }
          },
          "tef": {
            "_label": "tef",
            "_children": {

            }
          }
        }
      },
      "uii": {
        "_label": "uii",
        "_children": {
          "inl": {
            "_label": "inl",
            "_children": {

            }
          },
          "mti": {
            "_label": "mti",
            "_children": {
              "goi": {
                "_label": "goi",
                "_children": {

                }
              }
            }
          },
          "tci": {
            "_label": "tci",
            "_children": {
              "cei": {
                "_label": "cei",
                "_children": {

                }
              },
              "poi": {
                "_label": "poi",
                "_children": {

                }
              }
            }
          }
        }
      }
    }
  },
  "Periodontium": {
    "_label": "",
    "_children": {
      "app": {
        "_label": "app",
        "_children": {

        }
      },
      "cal": {
        "_label": "cal",
        "_children": {

        }
      },
      "map": {
        "_label": "map",
        "_children": {

        }
      },
      "smo": {
        "_label": "smo",
        "_children": {

        }
      },
      "tat": {
        "_label": "tat",
        "_children": {

        }
      }
    }
  },
  "Root": {
    "_label": "",
    "_children": {
      "Anomaly": {
        "_label": "",
        "_children": {
          "dex": {
            "_label": "dex",
            "_children": {

            }
          },
          "dix": {
            "_label": "dix",
            "_children": {

            }
          }
        }
      },
      "frx": {
        "_label": "frx",
        "_children": {

        }
      },
      "ifx": {
        "_label": "ifx",
        "_children": {

        }
      },
      "ipx": {
        "_label": "ipx",
        "_children": {

        }
      },
      "ppx": {
        "_label": "ppx",
        "_children": {

        }
      },
      "rfx": {
        "_label": "rfx",
        "_children": {
          "apx": {
            "_label": "apx",
            "_children": {

            }
          },
          "cox": {
            "_label": "cox",
            "_children": {

            }
          },
          "odx": {
            "_label": "odx",
            "_children": {

            }
          },
          "pex": {
            "_label": "pex",
            "_children": {

            }
          },
          "pox": {
            "_label": "pox",
            "_children": {

            }
          },
          "rex": {
            "_label": "rex",
            "_children": {

            }
          }
        }
      }
    }
  },
  "Status": {
    "_label": "",
    "_children": {
      "Invisible": {
        "_label": "",
        "_children": {
          "imx": {
            "_label": "imx",
            "_children": {

            }
          },
          "non": {
            "_label": "non",
            "_children": {

            }
          },
          "rrx": {
            "_label": "rrx",
            "_children": {

            }
          },
          "une": {
            "_label": "une",
            "_children": {

            }
          }
        }
      },
      "Visible": {
        "_label": "",
        "_children": {
          "cfr": {
            "_label": "cfr",
            "_children": {

            }
          },
          "eru": {
            "_label": "eru",
            "_children": {

            }
          },
          "imv": {
            "_label": "imv",
            "_children": {

            }
          },
          "nad": {
            "_label": "nad",
            "_children": {
              "int": {
                "_label": "int",
                "_children": {

                }
              },
              "sou": {
                "_label": "sou",
                "_children": {

                }
              }
            }
          },
          "pre": {
            "_label": "pre",
            "_children": {

            }
          },
          "rev": {
            "_label": "rev",
            "_children": {

            }
          },
          "rov": {
            "_label": "rov",
            "_children": {

            }
          },
          "tre": {
            "_label": "tre",
            "_children": {

            }
          }
        }
      },
      "mis": {
        "_label": "mis",
        "_children": {
          "mam": {
            "_label": "mam",
            "_children": {
              "apl": {
                "_label": "apl",
                "_children": {

                }
              },
              "ext": {
                "_label": "ext",
                "_children": {

                }
              },
              "sox": {
                "_label": "sox",
                "_children": {

                }
              }
            }
          },
          "mja": {
            "_label": "mja",
            "_children": {

            }
          },
          "mpm": {
            "_label": "mpm",
            "_children": {

            }
          }
        }
      }
    }
  },
  "Tooth position": {
    "_label": "",
    "_children": {
      "cro": {
        "_label": "cro",
        "_children": {

        }
      },
      "dia": {
        "_label": "dia",
        "_children": {

        }
      },
      "dis": {
        "_label": "dis",
        "_children": {

        }
      },
      "fve": {
        "_label": "fve",
        "_children": {

        }
      },
      "ipo": {
        "_label": "ipo",
        "_children": {

        }
      },
      "lve": {
        "_label": "lve",
        "_children": {

        }
      },
      "mal": {
        "_label": "mal",
        "_children": {

        }
      },
      "mig": {
        "_label": "mig",
        "_children": {

        }
      },
      "rot": {
        "_label": "rot",
        "_children": {

        }
      },
      "spa": {
        "_label": "spa",
        "_children": {

        }
      },
      "spo": {
        "_label": "spo",
        "_children": {

        }
      },
      "til": {
        "_label": "til",
        "_children": {

        }
      }
    }
  }
};
