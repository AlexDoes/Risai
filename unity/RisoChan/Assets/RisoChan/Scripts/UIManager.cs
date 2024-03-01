using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class UIManager : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private GameObject gameMenuPanel;
    [SerializeField] private GameObject mainGamePanel;
    [SerializeField] private GameObject gameOverPanel;
    

    void Awake()
    {
        GameManager.onGameStateChanged += HandleGameStateChangedCallback;
    }

    void OnDestroy()
    {
        GameManager.onGameStateChanged -= HandleGameStateChangedCallback;
    }
    void Start()
    {
        // setMainGamePanelActive();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    private void HandleGameStateChangedCallback(GameState gameState){
        switch(gameState){
            case GameState.MainMenu:
                setMenuPanelActive();
                break;
            case GameState.MainGame:
                setMainGamePanelActive();
                break;
            case GameState.GameOver:
                setGameOverPanelActive();
                break;
        }
    }

    private void setMenuPanelActive(){
        gameMenuPanel.SetActive(true);
        mainGamePanel.SetActive(false);
        gameOverPanel.SetActive(false);
    }

    private void setMainGamePanelActive(){
        gameMenuPanel.SetActive(false);
        mainGamePanel.SetActive(true);
        gameOverPanel.SetActive(false);
    }

    private void setGameOverPanelActive(){
        gameMenuPanel.SetActive(false);
        mainGamePanel.SetActive(false);
        gameOverPanel.SetActive(true);
    }

    public void RestartGame(){
        // GameManager.instance.RestartGame();
        SceneManager.LoadScene(0);
    }
}
